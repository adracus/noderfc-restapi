ModelFetcher = require "./model_fetcher"
User         = require "../models/user"

class UserFetcher extends ModelFetcher
  constructor: ->
    super('Z_PBR_EMPLOYEE_GET', 'ES_EMPLOYEE_DATA', User, {
      username:
        optional: true
        abapName: 'IV_USER_ID'
        type: "Char_12"
      id:
        optional: true
        abapName: 'IV_EMPLOYEE'
        type: "Numc_8"
      })

module.exports = UserFetcher