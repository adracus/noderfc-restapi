Model = require './model'

class WBSElement extends Model
  constructor: ->
    super({
      description:
        abapName: "POST1"
        type: "Char_40"
      id:
        abapName: "POSID"
        type: "Char_24"
      project:
        abapName: "PSPID"
        type: "Char_24"
    })

module.exports = WBSElement