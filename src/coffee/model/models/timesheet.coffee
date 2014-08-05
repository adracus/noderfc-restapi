Model = require "./model"


class TimeSheet extends Model
  constructor: ->
    super({
      counter:
        abapName: "COUNTER"
        type: "Char_12"
      status:
        abapName: "STATUS"
        type: "Char_2"
      status_text:
        abapName: "STATUS_TEXT"
        type: "Char_60"
      user_id:
        abapName: "EMPLOYEE"
        type: "Numc_8"
      workdate:
        abapName: "WORKDATE"
        type: "Dats"
      hours_planned:
        abapName: "HOURS_PLANNED"
        type: "Numc_4"
      hours_posted:
        abapName: "HOURS_POSTED"
        type: "Numc_4"
      unit:
        abapName: "UNIT"
        type: "Char_3"
      receiver_order:
        abapName: "REC_ORDER"
        type: "Char_12"
      cost_center:
        abapName: "COST_CNTR"
        type: "Char_10"
      network:
        abapName: "NETWORK"
        type: "Char_12"
      activity:
        abapName: "ACTIVITY"
        type: "Char_4"
      wbs_element:
        abapName: "WBS_ELEMENT"
        type: "Char_24"
      abs_att_type:
        abapName: "ABS_ATT_TYPE"
        type: "Char_4"
      activity_type:
        abapName: "ACTTYPE"
        type: "Char_6"
      delete_flag:
        abapName: "DELETE_FLAG"
        type: "Bool"
      reason:
        abapName: "REASON"
        type: "Char_4"
    })

module.exports = TimeSheet