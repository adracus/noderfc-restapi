ModelFetcher = require "./model_fetcher"
CompanyCode  = require "../models/company_code"

class CompanyCodeFetcher extends ModelFetcher
  constructor: () ->
    super('Z_PBR_COMP_CODE_GETLIST', 'ET_COMP_CODE', CompanyCode,{
      id:
        optional: true
        abapName: "IV_COMP_CODE"
        type: "Char_4"
      name:
        optional: true
        abapName: "IV_COMP_CODE_DESCR"
        type: "Char_25"
      max_records:
        optional: true
        abapName: "IV_MAXRECORDS"
        type: "Int_4"
    })

module.exports = CompanyCodeFetcher