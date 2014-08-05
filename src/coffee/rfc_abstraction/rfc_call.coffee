_             = require "underscore"
Type          = require "./types"
AttributeList = require "./attribute_list"

class RFCCall
  constructor: (@name, @inParams = {}, @outParams = {}, @shouldFilter = true, @ignoreErrors = false) ->
    @_inParams = AttributeList.parseAttributeList(@inParams)
    @_outParams = AttributeList.parseAttributeList(@outParams)

  getQueryParams: (params) -> _.pick(params, @_inParams.getAttributeNames())
  getFilterParams: (params) ->
    _.chain(params)
      .omit(@_inParams.getAttributeNames()) # Must not appear in input parameters
      .pick(@_outParams.getAttributeNames()) # Has to appear in the output params
      .value()

  createQuery: (params) -> @_inParams.encode(@getQueryParams(params))

  fetch: (conn, params, cb, filters = {}) ->
    query = @createQuery(params)
    conn.invoke(@name, query, ((err, res) ->
      if err or not res
        return cb(err)
      if not @ignoreErrors
        errorMessages = @getErrorMessages(res.ET_RETURN)
        if errorMessages.length > 0
          return cb(@convertErrorMessages(errorMessages))
      @onSuccess(res, cb, filters, params)
      ).bind this
    )

  filter: (filters, target, targetKey) ->
    return target if !@shouldFilter or _.keys(filters).length == 0
    if not targetKey
      return _.where(target, filters)
    _.where(target[targetKey], filters)

  onSuccess: (res, cb, filters, params) ->
    output = @_outParams.decode(res)
    cb(null, @filter(_.extend(filters, @getFilterParams(params)), output))

  getErrorMessages: (msgList) ->
    _.where(msgList, { TYPE: 'E'})

  convertErrorMessages: (errorMessages) ->
    _.reduce(errorMessages, ((memo, msg) -> 
      memo.errors.push(msg.MESSAGE)
      memo
    ), { errors: []})

module.exports = RFCCall