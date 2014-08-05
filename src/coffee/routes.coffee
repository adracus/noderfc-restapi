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
  if data && data.name
    return current_users[data.name.toUpperCase()]
  return undefined

formatRoutes = (routes) ->
  realRoutes = _.reject(routes, (route) -> route.route == undefined)
  _.map(realRoutes, (route) ->
    formatMethods(route.route.methods) + " " + route.route.path
  )

requestParams = (req) ->
  result = {}
  _.extend(result, req.body)
  _.extend(result, req.params)
  _.extend(result, req.query)
  result

doFetch = (req, res, fetcher, filters, idFetch) ->
  user = getAuthorizedUser(req)
  fetcher.fetch(user.conn, requestParams(req),
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
  return cb(null, getAuthorizedUser(req)) if getAuthorizedUser(req)
  credentials.getConnection (err, conn) ->
    if err or not conn
      console.error err
      return cb "No connection"
    new UserFetcher().fetch(conn, {username: credentials.username}, (err, user) ->
      if err or not user
        console.error err
        return cb "No user"
      user.conn = conn
      user.username = credentials.username
      current_users[credentials.username] = user
      cb(null, user)
    )

module.exports =
  auth: (req, res, next) ->
    doUserAuthorization(req, new Credentials(auth(req)), (err, user) ->
      if err or not user
        console.error err
        sendAuthFailedMessage res
      next()
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
    user.conn.close()
    delete current_users[user.username]
    return res.json(200, "You successfully logged out")

  userInfo: (req, res) ->
    res.json current_users[getAuthorizedUser(req).username].repr()

  userTimesheets: (req, res) ->
    getAuthorizedUser(req).getTimeSheets(requestParams(req),
      _.partial(onContent, res))

  userSettings: (req, res) ->
    getAuthorizedUser(req).getProfileSettings(requestParams(req),
      _.partial(onContent, res))

  userSettingsById: (req, res) ->
    getAuthorizedUser(req)
      .getProfileSettingsById(req, requestParams(req),
        _.partial(onContent, res))

  userActivityTypes: (req, res) ->
    getAuthorizedUser(req).getActivityTypes(requestParams(req),
      _.partial(onContent, res))

  getActivityTypes: (req, res) ->
    doFetch(req, res, new ActivityTypeFetcher())

  getActivityTypesById: (req, res) ->
    doFetch(req, res, new ActivityTypeFetcher(), {}, true)

  getTimeSheetsByUserId: (req, res) ->
    doFetch(req, res, new TimeSheetFetcher())

  getTimeSheets: (req, res) ->
    doFetch(req, res, new TimeSheetFetcher())

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

  ###getUserImage: (req, res) ->
    doFetch(req, res, new ImageCall())###

  postApproveReject: (req, res) ->
    doFetch(req, res, new ApproveRejectCall())

  postTimesheetData: (req, res) ->
    doFetch(req, res, new TimeEntryCall())