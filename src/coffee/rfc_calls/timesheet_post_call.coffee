RFCCall = require "../rfc_abstraction/rfc_call"

class TimeEntryCall extends RFCCall
  constructor: ->
    super("Z_PBR_TIMESHEET_POST", {
        user_id:
          optional: false
          abapName: "IV_EMPLOYEE"
          type: "Numc_8"
        profile_setting_id:
          optional: true
          abapName: "IV_PROFILE"
          type: "Char_8"
        new_timesheets:
          optional: true
          abapName: "IT_TS_DATA_INS"
          type:
            sender_cost_center:
              optional: false
              abapName: "SENDER_COST_CNTR"
              type: "Char_10"
            workdate:
              optional: false
              abapName: "WORKDATE"
              type: "Dats"
            hours_posted:
              optional: false
              abapName: "HOURS_POSTED"
              type: "Numc_4"
            receiver_order:
              optional: false
              abapName: "REC_ORDER"
              type: "Char_12"
            receiver_cost_center:
              optional: false
              abapName: "REC_COST_CNTR"
              type: "Char_10"
            network_id:
              optional: false
              abapName: "NETWORK"
              type: "Char_12"
            activity_id:
              optional: false
              abapName: "ACTIVITY"
              type: "Char_4"
            wbs_element_id:
              optional: false
              abapName: "WBS_ELEMENT"
              type: "Char_24"
            abs_att_type:
              optional: false
              abapName: "ABS_ATT_TYPE"
              type: "Char_4"
            activity_type_id:
              optional: false
              abapName: "ACTTYPE"
              type: "Char_6"
        change_timesheets:
          optional: true
          abapName: "IT_TS_DATA_INS"
          type:
            id:
              optional: false
              abapName: "COUNTER"
              type: "Char_12"
            sender_cost_center:
              optional: false
              abapName: "SENDER_COST_CNTR"
              type: "Char_10"
            workdate:
              optional: false
              abapName: "WORKDATE"
              type: "Dats"
            hours_posted:
              optional: false
              abapName: "HOURS_POSTED"
              type: "Numc_4"
            receiver_order:
              optional: false
              abapName: "REC_ORDER"
              type: "Char_12"
            receiver_cost_center:
              optional: false
              abapName: "REC_COST_CNTR"
              type: "Char_10"
            network_id:
              optional: false
              abapName: "NETWORK"
              type: "Char_12"
            activity_id:
              optional: false
              abapName: "ACTIVITY"
              type: "Char_4"
            wbs_element_id:
              optional: false
              abapName: "WBS_ELEMENT"
              type: "Char_24"
            abs_att_type:
              optional: false
              abapName: "ABS_ATT_TYPE"
              type: "Char_4"
            activity_type_id:
              optional: false
              abapName: "ACTTYPE"
              type: "Char_6"
        delete_timesheets:
          optional: true
          abapName: "IT_TS_DATA_DEL"
          type:
            id:
              optional: false
              abapName: "COUNTER"
              type: "Char_12"
      })

module.exports = TimeEntryCall