rfc                         = require 'node-rfc'
_                           = require 'underscore'
express                     = require 'express'
auth                        = require 'basic-auth'
Model                       = require './model/models/model'
UserFetcher                 = require './model/model_fetchers/user_fetcher'
TimeSheetFetcher            = require './model/model_fetchers/timesheet_fetcher'
ProfileSettingFetcher       = require './model/model_fetchers/profile_setting_fetcher'
ActivityTypeFetcher         = require './model/model_fetchers/activity_type_fetcher'
CompanyCodeFetcher          = require './model/model_fetchers/company_code_fetcher'
ControllingAreaFetcher      = require './model/model_fetchers/controlling_area_fetcher'
WBSElementFetcher           = require './model/model_fetchers/wbs_element_fetcher'
ReceiverOrderFetcher        = require './model/model_fetchers/receiver_order_fetcher'
RejectionReasonFetcher      = require './model/model_fetchers/rejection_reason_fetcher'
AbsAttTypeFetcher           = require './model/model_fetchers/abs_att_type_fetcher'
CostCenterFetcher           = require './model/model_fetchers/cost_center_fetcher'
ProcessingStatusFetcher     = require './model/model_fetchers/processing_status_fetcher'
WorklistFetcher             = require './model/model_fetchers/worklist_fetcher'
Credentials                 = require './credentials'
ApproveRejectCall           = require "./rfc_calls/approve_reject_call"
TimeEntryCall               = require "./rfc_calls/timesheet_post_call"
#ImageCall                   = require "./rfc_calls/image_call"

current_users  = {}
version = "0.0.2"

onContent = (res, err, data, idFetch) ->
  if err or not data
    console.error err
    return res.json(400, err)
  if _.isArray(data) and data.length > 0 and data[0] instanceof Model
    if idFetch
      if data.length > 1
        console.error "Invalid id fetch #{data}"
        return res.json(500, "Id fetch was invalid")
      return res.json(data[0].repr())
    return res.json(Model.reprSet(data))
  if data instanceof Model
    return res.json(data.repr())
  res.json(data)

getAuthorizedUser = (req) ->
  data = auth(req)
  if data && data.name && data.pass
    temp = current_users[data.name.toUpperCase()]
    if not temp or temp.password != data.pass
      return undefined
    return temp
  return undefined

formatRoutes = (routes) ->
  realRoutes = _.reject(routes, (route) -> route.route == undefined)
  _.map(realRoutes, (route) ->
    formatMethods(route.route.methods) + " " + route.route.path
  )

requestParams = (req) ->
  result = {}
  _.extend(result, req.params)
  _.extend(result, req.body) if req.method == "POST"
  _.extend(result, req.query) if req.method == "GET"
  result

doFetch = (req, res, fetcher, filters, idFetch) ->
  fetcher.fetch(req.conn, requestParams(req),
    _.partial(onContent, res, _, _, idFetch), filters)

formatMethods = (methods) ->
  resultList = []
  resultList.push("GET") if methods.get
  resultList.push("POST") if methods.post
  resultList.push("PATCH") if methods.patch
  resultList.push("PUT") if methods.put
  resultList.push("DELETE") if methods.delete
  resultList.push("TRACE") if methods.trace
  resultList.push("CONNECT") if methods.connect
  resultList.join(" | ")

sendAuthFailedMessage = (res) ->
  res.setHeader("WWW-Authenticate", 'Basic realm="TimesheetAPI"')
  res.json(401, "Unauthorized")

doUserAuthorization = (req, credentials, cb) ->
  return cb(credentials.getCorrectionString()) if not credentials.areValid()
  if getAuthorizedUser(req)
    req.conn = getAuthorizedUser(req).conn
    return cb(null, getAuthorizedUser(req))
  credentials.getConnection (err, conn) ->
    if err or not conn
      console.error err
      return cb "No connection"
    new UserFetcher().fetch(conn, {username: credentials.username}, (err, user) ->
      if err or not user
        console.error err
        return cb "No user"
      user.username = credentials.username
      user.password = credentials.password
      current_users[credentials.username] = user
      user.conn = conn
      req.conn = conn
      cb(null, user)
    )

module.exports =
  auth: (req, res, next) ->
    doUserAuthorization(req, new Credentials(auth(req)), (err, user) ->
      if err or not user
        console.error err
        return sendAuthFailedMessage res
      if not req.params.user or req.params.user == "me"
        req.user = user
        return next()
      new UserFetcher().fetch(req.conn, {id: req.param("user")}, (err, user) ->
        if not user
          return res.json(400, "User not found")
        req.user = user
        return next()
      )
    )

  index: (express, req, res) ->
    res.json({
      name: "Activity Recording",
      version: version,
      no_of_current_users: _.keys(current_users).length;
      routes: formatRoutes express._router.stack
    })

  logout: (req, res) ->
    user = getAuthorizedUser(req)
    req.conn.close()
    delete current_users[user.username]
    return res.json(200, "You successfully logged out")

  userInfo: (req, res) ->
    res.json req.user.repr()

  getActivityTypes: (req, res) ->
    doFetch(req, res, new ActivityTypeFetcher())

  getActivityTypesById: (req, res) ->
    doFetch(req, res, new ActivityTypeFetcher(), {}, true)

  getTimeSheets: (req, res) ->
    fetcher = new TimeSheetFetcher()
    params = requestParams(req)
    user = req.user
    params.user_id = user.id if not params.user_id
    fetcher.fetch(req.conn, params,
      _.partial(onContent, res, _, _, false), {})

  getTimeSheetsById: (req, res) ->
    fetcher = new TimeSheetFetcher()
    params = requestParams(req)
    params.ids = [{id: params.id}]
    delete params.id
    user = req.user
    params.user_id = user.id if not params.user_id
    fetcher.fetch(req.conn, params,
      _.partial(onContent, res, _, _, true), {})

  getProfileSettings: (req, res) ->
    doFetch(req, res, new ProfileSettingFetcher())

  getProfileSettingsById: (req, res) ->
    doFetch(req, res, new ProfileSettingFetcher(), {}, true)

  getAbsAttTypes: (req, res) ->
    doFetch(req, res, new AbsAttTypeFetcher())

  getAbsAttTypesById: (req, res) ->
    doFetch(req, res, new AbsAttTypeFetcher(), {}, true)

  getCompanyCodes: (req, res) ->
    doFetch(req, res, new CompanyCodeFetcher())

  getCompanyCodesById: (req, res) ->
    doFetch(req, res, new CompanyCodeFetcher(), {}, true)

  getCostCenters: (req, res) ->
    doFetch(req, res, new CostCenterFetcher())

  getCostCentersById: (req, res) ->
    doFetch(req, res, new CostCenterFetcher(), {}, true)  

  getControllingAreas: (req, res) ->
    doFetch(req, res, new ControllingAreaFetcher())

  getControllingAreasById: (req, res) ->
    doFetch(req, res, new ControllingAreaFetcher(), {}, true)

  getRejectionReasons: (req, res) ->
    doFetch(req, res, new RejectionReasonFetcher())

  getRejectionReasonsById: (req, res) ->
    doFetch(req, res, new RejectionReasonFetcher(), {}, true)

  getProcessingStatuses: (req, res) ->
    doFetch(req, res, new ProcessingStatusFetcher())

  getProcessingStatusesById: (req, res) ->
    doFetch(req, res, new ProcessingStatusFetcher(), {}, true)

  getReceiverOrders: (req, res) ->
    doFetch(req, res, new ReceiverOrderFetcher())

  getReceiverOrdersById: (req, res) ->
    doFetch(req, res, new ReceiverOrderFetcher(), {}, true)

  getWBSElements: (req, res) ->
    doFetch(req, res, new WBSElementFetcher())

  getWBSElementsById: (req, res) ->
    doFetch(req, res, new WBSElementFetcher(), {}, true)

  getWorklists: (req, res) ->
    doFetch(req, res, new WorklistFetcher())

  ###getUserImage: (req, res) ->
    doFetch(req, res, new ImageCall())###

  postApproveReject: (req, res) ->
    doFetch(req, res, new ApproveRejectCall())

  postTimesheetData: (req, res) ->
    doFetch(req, res, new TimeEntryCall())

  deleteTimeSheetById: (req, res) ->
    call = new TimeEntryCall()
    params = requestParams(req)
    params.delete_timesheets = [{id: params.id}]
    delete params.id
    user = req.user
    params.user_id = user.id if not params.user_id
    call.fetch(req.conn, params,
      _.partial(onContent, res, _, _, true), {})