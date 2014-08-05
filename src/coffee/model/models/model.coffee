_ = require('underscore')
AttributeList = require "../../rfc_abstraction/attribute_list"

class Model
  constructor: (@attributes = {}) ->
    prepare = _.clone(@attributes)
    _.each(prepare, (value, key) ->
      if _.isFunction(value.type)
        value.type = new value.type()._attributes
    )
    @_attributes = AttributeList.parseAttributeList(prepare)

  decode: (set) ->
    _.extend(this, @_attributes.decode(set))
    return this

  encode: () -> @_attributes.encode(this)

  repr: () -> _.omit(this, 'attributes', '_attributes')

  @decodeSet: (set, clazz) ->
    if not _.isArray(set)
      return new clazz().decode(set)
    _.map(set, (item) ->
      return new clazz().decode(item)
    )

  @reprSet: (set) ->
    if not _.isArray(set) then set.repr() else _.map(set, (m) -> m.repr())
      

module.exports= Model