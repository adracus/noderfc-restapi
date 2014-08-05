RFCCall = require "../rfc_abstraction/rfc_call"
fs = require "fs"
path = require "path"
_ = require "underscore"

class ImageCall extends RFCCall
  constructor: ->
    super('Z_PBR_EMPLOYEE_GET', {
      id:
        optional: true
        abapName: 'IV_EMPLOYEE'
        type: "Numc_8"
      })

  fetch: (conn, params, cb, filters = {}) ->
    pathToImage = path.resolve(__dirname, "../../../res/images/users/#{params.id}.jpg")
    fs.exists(pathToImage, ((exists) ->
      if exists
        return cb(null, pathToImage)
      super(conn, params, cb, filters)
      ).bind this
    )

  onSuccess: (res, cb, filters, params) ->

    pathToImage = path.resolve(__dirname, "../../../res/images/users/#{params.id}.jpg")
    imgString = _.map(res.ET_FOTO_CONTENT, (obj) ->
      obj.LINE
    ).join("")
    imgString = imgString.replace(/\x00$/, "")
    imgString = "data:image/jpg;base64," + imgString
    console.log imgString
    imgString = new Buffer(imgString).toString "base64"
    fs.writeFile(pathToImage, imgString, (err) ->
      if err then cb err else cb(null, pathToImage)
    )

module.exports = ImageCall