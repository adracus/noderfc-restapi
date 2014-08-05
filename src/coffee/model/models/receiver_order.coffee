Model = require './model'

class ReceiverOrder extends Model
  constructor: ->
    super({
      id:
        abapName: "AUFNR"
        type: "Char_12"
      description:
        abapName: "KTEXT"
        type: "Char_40"
      company_code:
        abapName: "BUKRS"
        type: "Char_4"
      controlling_area:
        abapName: "KOKRS"
        type: "Char_4"
      cost_center:
        abapName: "KOSTL"
        type: "Char_10"
    })

module.exports = ReceiverOrder