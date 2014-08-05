_         = require "underscore"
Attribute = require "./attribute"
u         = require "../util"

class AttributeList
  constructor: (@attributes, @name, @abapName) ->
    @_byName = {}
    @_byAbapName = {}
    _.each(@attributes, ((attribute) ->
      @_byName[attribute.name] = attribute
      @_byAbapName[attribute.abapName] = attribute
      ).bind this
    )

  decode: (val) ->
    u.objMap(val, ((value, key) ->
      attribute = @_byAbapName[key]
      if attribute
        if _.isArray(value)
          return u.nuObj(attribute.name,
            _.map(value, attribute.decode.bind attribute))
        return u.nuObj(attribute.name, attribute.decode(value))
      return {}
      ).bind this
    )

  encode: (val) ->
    u.objMap(val, ((value, key) ->
      attribute = @_byName[key]
      if attribute
        if _.isArray(value)
          return u.nuObj(attribute.abapName,
            _.map(value, attribute.encode.bind attribute))
        return u.nuObj(attribute.abapName, attribute.encode(value))
      return {}
      ).bind this
    )

  getAttributeNames: -> _.keys(@_byName)
  getAttributeAbapNames: -> _.keys(@_byAbapName)
  hasAttributeWithAbapName: (abapName) -> @_byAbapName[abapName]?
  hasAttributeWithName: (name) -> @_byName[name]?

  @parseAttributeList: (obj) ->
    return obj if obj instanceof AttributeList
    new AttributeList _.map(obj, Attribute.parseAttribute)


module.exports = AttributeList