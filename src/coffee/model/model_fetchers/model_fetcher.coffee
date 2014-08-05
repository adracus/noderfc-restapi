RFCCall = require "../../rfc_abstraction/rfc_call"
Model   = require "../models/model"
_       = require "underscore"

class ModelFetcher extends RFCCall
  constructor: (rfc_name, @target, @model_type, inParams) ->
    super(rfc_name, inParams, new @model_type()._attributes)

  onSuccess: (res, cb, filters, params) ->
    try
      rfc_result = if @target then res[@target] else res
      output = Model.decodeSet(rfc_result, @model_type)
      if _.isArray(output)
        return cb(null, @filter(_.extend(filters, @getFilterParams(params)),
          output))
      return cb(null, output)

    catch error
      console.error error
      cb(error)

module.exports = ModelFetcher