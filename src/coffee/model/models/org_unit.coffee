Model = require './model'

class OrgUnit extends Model
  constructor: ->
    super({
      id:
        abapName: "OBJID"
        type: "Numc_8"
      name:
        abapName: "MC_STEXT"
        type: "Char_40"
    })


module.exports = OrgUnit