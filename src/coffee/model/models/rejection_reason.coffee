Model = require './model'

class RejectionReason extends Model
  constructor: ->
    super({
      id:
        abapName: "REASON"
        type: "Char_4"
      description:
        abapName: "TEXT"
        type: "Char_50"
    })

module.exports = RejectionReason