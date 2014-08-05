Model        = require "../models/model"
ModelFetcher = require "./model_fetcher"
TimeSheet    = require "../models/timesheet"

class TimeSheetFetcher extends ModelFetcher
  constructor: ->
    super('Z_PBR_TIMESHEET_GET', "", TimeSheet, {
      start_date:
        optional: true,
        abapName: 'IV_START_DATE'
        type: "Dats"
      end_date:
        optional: true
        abapName: 'IV_END_DATE'
        type: "Dats"
      user_id:
        optional: true
        abapName: 'IV_EMPLOYEE'
        type: "Numc_8"
    })

module.exports = TimeSheetFetcher