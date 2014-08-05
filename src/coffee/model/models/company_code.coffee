Model = require './model'

class CompanyCode extends Model
  constructor: ->
    super({
      id:
        abapName: "COMP_CODE"
        type: "Char_4"
      name:
        abapName: "COMP_CODE_DESCR"
        type: "Char_25"
    })

module.exports = CompanyCode