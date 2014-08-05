ModelFetcher    = require "./model_fetcher"
ProfileSetting  = require "../models/profile_setting"

class ProfileSettingFetcher extends ModelFetcher
  constructor: ->
    super("Z_PBR_PROFILE_GETLIST", "ET_PROFILE_SETTINGS", ProfileSetting, {
      user_id:
        abapName: 'IV_USER_ID'
        type: "Char_12"
    })

module.exports = ProfileSettingFetcher