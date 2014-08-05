Model = require './model'

class NetworkActivity extends Model
  constructor: ->
    super({
      order_number:
        abapName: "AUFNR"
        type: "Char_12"
      id:
        abapName: "VORNR"
        type: "Char_4"
      description:
        abapName: "LTXA1"
        type: "Char_40"
    })

module.exports = NetworkActivity