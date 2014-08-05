Model = require './model'

class AbsAttType extends Model
  constructor: ->
    super({
      client:
        abapName: "MANDT"
        type: "Numc_3"
      moabw:
        abapName: "MOABW"
        type: "Numc_2"
      id:
        abapName: "SUBTY"
        type: "Char_4"
      end_date:
        abapName: "ENDDA"
        type: "Dats"
      description:
        abapName: "ATEXT"
        type: "Char_25"
      indicator:
        abapName: "ART01"
        type: "Char_1"
    })

module.exports = AbsAttType