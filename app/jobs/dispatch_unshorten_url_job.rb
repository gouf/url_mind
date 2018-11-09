# frozen_string_literal: true

# Find shoten-URL and dispatch unshorten-URL job
class DispatchUnshortenUrlJob < ApplicationJob
  queue_as :default

  # Find Short-URL and dispatch unshorten job
  # like t.co, buff.ly, bit.ly, etc (now only t.co)
  def perform
    twitter_url =
      ReadLater.where('url like :twitter', twitter: '%t.co%')
               .first(100)

    twitter_url.each do |record|
      UpdateToUnshortenUrlJob.perform_later(id: record.id)
    end
  end
end
