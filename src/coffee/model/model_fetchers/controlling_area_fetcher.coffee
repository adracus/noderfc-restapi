ModelFetcher    = require "./model_fetcher"
ControllingArea = require "../models/controlling_area"

class ControllingAreaFetcher extends ModelFetcher
  constructor: ->
    super('Z_PBR_CO_AREA_GETLIST', 'ET_CO_AREA', ControllingArea,{
      id:
        optional: true
        abapName: "IV_CO_AREA"
        type: "Char_4"
      name:
        optional: true
        abapName: "IV_CO_AREA_TEXT"
        type: "Char_25"
      max_records:
        optional: true
        abapName: "IV_MAXRECORDS"
        type: "Int_4"
    })

module.exports = ControllingAreaFetcher