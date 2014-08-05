Model = require './model'

class ProcessingStatus extends Model
  constructor: ->
    super({
      id:
        abapName: "STATUS"
        type: "Char_2"
      description:
        abapName: "STAT_DESCR"
        type: "Char_60"
    })

module.exports = ProcessingStatus