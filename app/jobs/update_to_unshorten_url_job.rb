# frozen_string_literal: true

# Update url to unshorten-URL (receive order from Dispatchunshortenurljob)
class UpdateToUnshortenUrlJob < ApplicationJob
  queue_as :default

  # Update the Readlater record to unshorten URL
  # @param args [Hash] passes id with number (eg. id: 1)
  def perform(**args)
    record = ReadLater.find(args[:id])
    unshorten_url = Unshorten[record.url]
    record.url = unshorten_url
    record.save
  end
end
