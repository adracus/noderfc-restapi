Model = require './model'

class CostCenter extends Model
  constructor: ->
    super({
      id:
        abapName: "KOSTL"
        type: "Char_10"
      controlling_area_id:
        abapName: "KOKRS"
        type: "Char_4"
      company_code:
        abapName: "BUKRS"
        type: "Char_4"
      name:
        abapName: "MCTXT"
        type: "Char_20"
    })

module.exports = CostCenter