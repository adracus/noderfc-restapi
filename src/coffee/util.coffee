_ = require "underscore"

nuObj = (key, val) ->
  result = {}
  result[key] = val
  return result

objMap = (object, func) ->
  result = {}
  _.each(object, (value, key, list) ->
    _.extend(result, func(value, key, list))
  )
  result


module.exports =
  objMap: objMap
  nuObj: nuObj