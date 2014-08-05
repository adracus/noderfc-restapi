ModelFetcher = require "./model_fetcher"
ActivityType = require "../models/activity_type"

class ActivityTypeFetcher extends ModelFetcher
  constructor: ->
    super('Z_PBR_ACTIVITY_TYPES_GETLIST', 'ET_ACTIVITY_TYPES', ActivityType,{
        controlling_area:
          optional: false
          abapName: "IV_CO_AREA"
          type: "Char_10"
        cost_center:
          optional: true
          abapName: "IV_COSTCENTER"
          type: "Char_4"
      })

module.exports = ActivityTypeFetcher