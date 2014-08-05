AbsAttType    = require "../models/abs_att_type"
ModelFetcher  = require "./model_fetcher"

class AbsAttTypeFetcher extends ModelFetcher
  constructor: ->
    super('Z_PBR_ABS_ATTEND_TYPE_GETLIST',
      'ET_ABS_ATTEND_TYPES', AbsAttType)

module.exports = AbsAttTypeFetcher