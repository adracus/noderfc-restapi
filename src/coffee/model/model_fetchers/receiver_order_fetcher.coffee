ModelFetcher  = require "./model_fetcher"
ReceiverOrder = require "../models/receiver_order"

class ReceiverOrderFetcher extends ModelFetcher
  constructor: ->
    super('Z_PBR_RECEIVER_ORDER_GETLIST', 'ET_REC_ORDERS', ReceiverOrder,
      {
        id:
          optional: true
          abapName: "IV_ORDER"
          type: "Char_12"
        description:
          optional: true
          abapName: "IV_ORDER_TEXT"
          type: "Char_40"
        company_code:
          optional: true
          abapName: "IV_COMPANY_CODE"
          type: "Char_4"
        cost_center:
          optional: true
          abapName: "IV_COST_CENTER"
          type: "Char_10"
        controlling_area:
          optional: true
          abapName: "IV_CO_AREA"
          type: "Char_4"
        max_records:
          optional: true
          abapName: "IV_MAXRECORDS"
          type: "Int_4"
      })

module.exports = ReceiverOrderFetcher