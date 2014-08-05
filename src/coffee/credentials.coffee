abap  = require '../../res/sapnwrfc.json'
_     = require 'underscore'
rfc   = require 'node-rfc'

class Credentials
  constructor: (@username, @password) ->
    if _.isObject(@username)
      @password = @username.pass
      @username = @username.name.toUpperCase() if username.name

  areValid: () -> @username and @password;

  getCorrectionString: () ->
    ls = []
    if not @username
      ls.push("username is missing")
    if not @password
      ls.push("password is missing")
    ls.join(" AND ")

  getConnection: (cb) ->
    if @areValid()
      conn_params = _.clone(abap.I64)
      conn_params.user = @username
      conn_params.passwd = @password
      client = new rfc.Client(conn_params, true)
      return client.connect((err) -> 
        if err
          return cb(err)
        return cb(err, client)
      )
    return cb(@getCorrectionString())

module.exports = Credentials