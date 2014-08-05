ModelFetcher      = require "./model_fetcher"
ProcessingStatus  = require "../models/processing_status"

class ProcessingStatusFetcher extends ModelFetcher
  constructor: ->
    super("Z_PBR_PROCESS_STATUS_GETLIST", "ET_PROCESSING_STATUS",
      ProcessingStatus)

module.exports = ProcessingStatusFetcher