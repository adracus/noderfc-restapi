ModelFetcher    = require "./model_fetcher"
NetworkActivity = require "../models/network_activity"

class NetworkActivityFetcher extends ModelFetcher
  constructor: ->
    super('Z_PBR_NETW_ACTIVITY_GETLIST', 'ET_ACTIVITIES', NetworkActivity, {
        order_number:
          optional: true
          abapName: "IV_NETWORK"
          type: "Char_12"
        id:
          optional: true
          abapName: "IV_ACTIVITY"
          type: "Char_4"
        description:
          optional: true
          abapName: "IV_ACTIVITY_TEXT"
          type: "Char_40"
        max_records:
          optional: true
          abapName: "IV_MAXRECORDS"
          type: "Int_4"
    })

module.exports = NetworkActivityFetcher