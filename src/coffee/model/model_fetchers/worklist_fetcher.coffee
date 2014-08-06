ModelFetcher = require "./model_fetcher"
Worklist = require "../models/worklist"

class WorklistFetcher extends ModelFetcher
  constructor: ->
    super("Z_PBR_WORKLIST_GET", "", Worklist, {
      profile_id:
        optional: false
        abapName: "IV_PROFILE"
        type: "Char_8"
      user_id:
        optional: false
        abapName: "IV_EMPLOYEE"
        type: "Numc_8"
      key_date:
        optional: true
        abapName: "IV_KEY_DATE"
        type: "Dats"
    })

module.exports = WorklistFetcher