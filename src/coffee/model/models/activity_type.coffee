Model = require './model'

class ActivityType extends Model
  constructor: ->
    super({
      id:
        abapName: "ACTTYPE"
        type: "Char_6"
      name:
        abapName: "ACTTYP_TXT"
        type: "Char_20"
    })

module.exports = ActivityType