ModelFetcher = require "./model_fetcher"
CostCenter   = require "../models/cost_center"

class CostCenterFetcher extends ModelFetcher
  constructor: ->
    super('Z_PBR_COST_CENTER_GETLIST', 'ET_COSTCENTER', CostCenter, {
        controlling_area_id:
          optional: true
          abapName: "IV_CO_AREA"
          type: "Char_4"
        id:
          optional: true
          abapName: "IV_COSTCENTER"
          type: "Char_10"
        company_code:
          optional: true
          abapName: "IV_COMPANY_CODE"
          type: "Char_4"
        name:
          optional: true
          abapName: "IV_COSTCENTER_TEXT"
          type: "Char_20"
        max_records:
          optional: true
          abapName: "IV_MAXRECORDS"
          type: "Int_4"
    })

module.exports = CostCenterFetcher