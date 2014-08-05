RFCCall = require "../rfc_abstraction/rfc_call"

class ApproveRejectCall extends RFCCall
  constructor: ->
    super("Z_PBR_TIMESHEET_APPROVE_REJECT", {
      send_notification:
        optional: true
        abapName: "IV_SEND_MAIL"
        type: "Bool"
      immediate_transfer_to_hr:
        optional: true
        abapName: "IV_DIRECT_HR"
        type: "Bool"
      data:
        optional: false
        abapName: "IT_DAILY_TS"
        type:
          user_id:
            optional: false
            abapName: "EMPLOYEE"
            type: "Numc_8"
          counter:
            optional: false
            abapName: "COUNTER"
            type: "Char_12"
          reason:
            optional: false
            abapName: "REASON"
            type: "Char_4"
          status:
            optional: false
            abapName: "STATUS"
            type: "Char_2"
    })

module.exports = ApproveRejectCall