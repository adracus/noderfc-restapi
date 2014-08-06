_     = require "underscore"
Model = require "./model"

class Worklist extends Model
  constructor: ->
    super({
        start_date:
          abapName: "EV_START_DATE"
          type: "Dats"
        end_date:
          abapName: "EV_END_DATE"
          type: "Dats"
        worklist:
          abapName: "ET_WORKLIST"
          type:
            activity_type:
              abapName: "ACTTYPE"
              type: "Char_6"
            cost_center:
              abapName: "COST_CNTR"
              type: "Char_10"
            wbs_element:
              abapName: "WBS_ELEMENT"
              type: "Numc_8"
            receiver_order:
              abapName: "REC_ORDER"
              type: "Char_12"
            network:
              abapName: "NETWORK"
              type: "Char_12"
            activity:
              abapName: "ACTIVITY"
              type: "Char_4"
      })

  onDecoded: (set) ->
    _.each(set.ET_WORKLIST, ((element, index) ->
      ct = 1
      @worklist[index].days = []
      while _.has(element, "DAY#{ct}")
        @worklist[index].days.push element["DAY#{ct}"]
        ct = ct + 1
      ).bind this
    )

module.exports = Worklist