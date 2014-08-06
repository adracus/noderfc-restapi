fs          = require "fs"
http        = require "http"
https       = require "https"
_           = require "underscore"
express     = require "express"
bodyParser  = require "body-parser"
path        = require "path"
routes      = require "./routes"
Credentials = require "./credentials"

app = express()
app.use bodyParser.json()

app.use (err, req, res, next) ->
  console.error err
  res.json(500, {
    msg: "Internal server error. Take this potato."
    potato: "http://upload.wikimedia.org/wikipedia/commons/thumb/4/4c/Potato_heart_mutation.jpg/686px-Potato_heart_mutation.jpg"
  })

# Index and management routes
app.get("/", _.partial(routes.index, app))
app.get("/doc", (req, res) ->
  res.sendfile path.resolve(__dirname + "/../../doc/gen/docu.html"))

# Authorization routes
app.get("/logout", routes.auth, routes.logout)


# User specific routes
app.get("/user/me", routes.auth, routes.userInfo)
app.get("/user/me/settings", routes.auth, routes.userSettings)
app.get("/user/me/settings/:id", routes.auth, routes.userSettingsById)
app.get("/user/me/timesheet", routes.auth, routes.userTimesheets)
app.get("/user/me/activity_types", routes.auth,
  routes.userActivityTypes)

# Specified User routes
app.get("/user/:id/timesheet", routes.auth,
  routes.getTimeSheetsByUserId)
#app.get("/user/:id/image", routes.auth, routes.getUserImage)

# Query routes
app.get("/timesheets", routes.auth, routes.getTimeSheets)
app.post("/timesheets/post", routes.auth, routes.postTimesheetData) #ugly

app.get("/abs_att_types", routes.auth, routes.getAbsAttTypes)
app.get("/abs_att_types/:id", routes.auth, routes.getAbsAttTypesById)

app.get("/activity_types", routes.auth, routes.getActivityTypes)
app.get("/activity_types/:id", routes.auth, routes.getActivityTypesById)

app.get("/company_codes", routes.auth, routes.getCompanyCodes)
app.get("/company_codes/:id", routes.auth, routes.getCompanyCodesById)

app.get("/cost_centers", routes.auth, routes.getCostCenters)
app.get("/cost_centers/:id", routes.auth, routes.getCostCentersById)

app.get("/controlling_areas", routes.auth, routes.getControllingAreas)
app.get("/controlling_areas/:id", routes.auth,
  routes.getControllingAreasById)

app.get("/rejection_reasons", routes.auth, routes.getRejectionReasons)
app.get("/rejection_reasons/:id", routes.auth,
  routes.getRejectionReasonsById)

app.get("/receiver_orders", routes.auth, routes.getReceiverOrders)
app.get("/receiver_orders/:id", routes.auth, routes.getReceiverOrdersById)

app.get("/wbs_elements", routes.auth, routes.getWBSElements)
app.get("/wbs_elements/:id", routes.auth, routes.getWBSElementsById)

app.get("/processing_statuses", routes.auth,
  routes.getProcessingStatuses)
app.get("/processing_statuses/:id", routes.auth,
  routes.getProcessingStatusesById)

# Data entry routes
app.post("/timesheets/approve_reject", routes.auth,
  routes.postApproveReject)

options =
  key: fs.readFileSync(__dirname + '/../../res/key.pem')
  cert: fs.readFileSync(__dirname + '/../../res/cert.pem')


server = https.createServer(options, app)
server.listen 443

redirectServer = express()

redirectServer.get("/*", (req, res) ->
  return res.redirect "https://#{req.host}#{req.url}"
)

redirectServer.listen 80