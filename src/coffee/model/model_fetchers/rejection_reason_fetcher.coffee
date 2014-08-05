ModelFetcher    = require "./model_fetcher"
RejectionReason = require "../models/rejection_reason"

class RejectionReasonFetcher extends ModelFetcher
  constructor: ->
    super("Z_PBR_REJECT_REASON_GETLIST", "ET_REJECTION_REASON", RejectionReason)

module.exports = RejectionReasonFetcher