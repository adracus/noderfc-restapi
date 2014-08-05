Model    = require "./model"

class ProfileSetting extends Model
  constructor: ->
    super({
      id:
        abapName: "VARIANT"
        type: "Char_8"
      description:
        abapName: "PROFILE_DESCR"
        type: "Char_50"
      daytext:
        abapName: "DAYTEXT"
        type: "Bool"
      calendar:
        abapName: "CALENDAR"
        type: "Char_1"
      sumrow:
        abapName: "SUMROW"
        type: "Bool"
      pertype:
        abapName: "PERTYPE"
        type: "Char_1"
      firstdayof:
        abapName: "FIRSTDAYOF"
        type: "Numc_1"
      catsperiod:
        abapName: "CATSPERIOD"
        type: "Numc_2"
      type:
        abapName: "DEF_ABS_ATT_TYPE"
        type: "Char_4"
      is_default:
        abapName: "IS_DEFAULT"
        type: "Bool"
    })

module.exports = ProfileSetting