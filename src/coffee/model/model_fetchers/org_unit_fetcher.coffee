ModelFetcher = require "./model_fetcher"
OrgUnit      = require "./models/org_unit"

class OrgUnitFetcher extends ModelFetcher
  constructor: ->
    super('Z_PBR_ORG_UNIT_GETLIST', 'ET_ORG_UNIT', OrgUnit, {
        id:
          optional: true
          abapName: 'IV_ORG_UNIT'
          type: "Char_8"
        name:
          optional: true
          abapName: 'IV_ORG_UNIT_TEXT'
          type: "Char_25"
        max_records:
          optional: true
          abapName: 'IV_MAXRECORDS'
          type: "Int_4"
    })

module.exports = OrgUnitFetcher