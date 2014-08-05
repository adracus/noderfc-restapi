_    = require "underscore"
Type = require "./types"

class Attribute
  constructor: (@name, @abapName, @type, @optional = false) ->

  decode: (val) ->
    if val != undefined 
      return @type.decode(val)
    if @type instanceof Bool
      return false;
    if @type instanceof Char
      return "";
    throw "Variable #{@abapName} not existent"

  encode: (val) ->
    if val then @type.encode val else undefined

  @parseAttribute: (obj, name) ->
    abapName = obj.abapName
    type = obj.type
    optional = obj.optional
    if _.isObject(type)
      if type instanceof require "./attribute_list"
        type.name = name
        type.abapName = abapName
        type.optional = optional
        return type
      return new Attribute(name, abapName,
        require("./attribute_list").parseAttributeList(type), optional)
    return new Attribute(name, obj.abapName, Type.parseType(obj.type),
      obj.optional) 

module.exports = Attribute