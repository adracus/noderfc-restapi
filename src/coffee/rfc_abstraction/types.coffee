_ = require "underscore"
u = require "../util"

fillUp = (val, len, filler = "0", leading = true) ->
  result = val.toString()
  while result.length < len
    if leading
      result = filler + result
    else
      result = result + filler
  result

capitalize= (name) ->
  result = name.toLowerCase()
  result.charAt(0).toUpperCase() + result.slice(1)

types =
  Char: (len, trim) -> new Char(len, trim)
  Bool: -> new Bool()
  Str: -> new Str()
  Int: (len) -> new Int(len)
  Numc: (len) -> new Numc(len)
  Dats: -> new Dats()

class Type
  constructor: () ->

  decode: (val) -> throw "Not overridden error"
  encode: (val) -> throw "Not overridden error"

  @parseType: (type) ->
    return type if type instanceof Type
    if _.isString(type) # Type has to be a string literal
      if type.indexOf("_") > -1
        parts = type.split("_")
        len = parseInt parts[1]
        return types[capitalize(parts[0])](len)
      return types[type]()
    throw "Could not parse type " + type

class Char extends Type
  constructor: (@len, @trim = true) ->

  rtrim: (val) -> val.toString().replace(/\s+$/,'')
  ltrim: (val) -> val.toString().replace(/^\s+/,'')

  decode: (val) -> if @trim then @rtrim(val) else value.toString()
  encode: (val) -> if @trim then fillUp(val, @len, " ", false) else value.toString()

class Bool extends Type
  constructor: () ->

  decode: (val) -> if val and val == "X" then true else false
  encode: (val) -> if val and val == true then "X" else ""

class Int extends Type
  constructor: (@len) ->

  decode: (val) -> parseInt val
  encode: (val) -> val

class Str extends Type
  constructor: ->

  decode: (val) -> val.toString()
  encode: (val) -> val.toString()

class Dats extends Type
  constructor: () ->

  decode: (val) ->
    val  = val.toString()
    year      = parseInt val.substring(0, 4)
    month     = parseInt val.substring(4, 6) - 1
    day       = parseInt val.substring(6, 8)
    new Date(year, month, day)
  encode: (val) ->
    val = new Date(val) if val not instanceof Date
    year  = fillUp(val.getFullYear(), 4)
    month = fillUp(val.getMonth() + 1, 2)
    day   = fillUp(val.getUTCDate(), 2)
    return parseInt year + month + day

class Numc extends Type
  constructor: (@len) ->

  decode: (val) -> parseInt val
  encode: (val) -> fillUp(val, @len)

module.exports = Type