Model = require './model'

class ControllingArea extends Model
  constructor: ->
    super({
      id:
        abapName: "KOKRS"
        type: "Char_4"
      name:
        abapName: "BEZEI"
        type: "Char_20"
    })

module.exports = ControllingArea