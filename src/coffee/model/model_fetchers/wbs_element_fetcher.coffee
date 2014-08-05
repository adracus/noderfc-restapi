ModelFetcher = require "./model_fetcher"
WBSElement   = require "../models/wbs_element"

class WBSElementFetcher extends ModelFetcher
  constructor: ->
    super('Z_PBR_WBS_ELEMENT_GETLIST', 'ET_WBS', WBSElement, {
      description:
        optional: true
        abapName: "IV_WBS_TEXT"
        type: "Char_40"
      id:
        optional: true
        abapName: "IV_WBS"
        type: "Char_24"
      project:
        optional: true
        abapName: "IV_PROJECT"
        type: "Char_24"
    })

module.exports = WBSElementFetcher