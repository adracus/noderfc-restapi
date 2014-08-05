Model = require "./model"

class EmployeeTimeSheetAggregated extends Model
  constructor: ->
    super({
      employee_id:
        abapName: "EMPLOYEE"
        type: "Numc_8"
      employee_last_name:
        abapName: "LAST_NAME"
        type: "Char_25"
      employee_first_name:
        abapName: "FIRSTNAME"
        type: "Char_25"
      total_planned:
        abapName: "TOTAL_PLANNED"
        type: "Numc_4"
      total_posted:
        abapName: "TOTAL_POSTED"
        type: "Numc_4"
      total_approved:
        abapName: "TOTAL_APPROVED"
        type: "Numc_4"
      total_rejected:
        abapName: "TOTAL_REJECTED"
        type: "Numc_4"
      unit:
        abapName: "UNIT"
        type: "Char_3"
    })

class EmployeeTimeSheetDaily extends Model
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

class TimeSheet extends Model
  constructor: ->
    super({
      aggregated:
        abapName: "ET_TS_DATA"
        type: EmployeeTimeSheetAggregated
      daily:
        abapName: "ET_DAILY_TS"
        type: EmployeeTimeSheetDaily
    })

module.exports = TimeSheet