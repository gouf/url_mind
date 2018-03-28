# frozen_string_literal: true

require 'url_accessible'

# Delete Readlater record if that URL is 404 (receive order from Dispatch404UrlDeletionJob)
class Delete404UrlJob < ApplicationJob
  queue_as :default

  # Delete the Readlater record if that is non accessible
  # @param args [Hash] passes id with number (eg. id: 1)
  def perform(**args)
    record = ReadLater.find(args[:id])
    record.destroy if UrlAccessible.not_found?(record.url)
  end
end
