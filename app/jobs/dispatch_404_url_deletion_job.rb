# frozen_string_literal: true

# Search 404 response URL and dispatch deletion
class Dispatch404UrlDeletionJob < ApplicationJob
  queue_as :default

  # Find the 404 records within all of the ReadLater
  # To manage for split to processing group and process delay
  def perform
    job_grouping =
      JobGrouping.new(ReadLater.all.pluck(:id), group_delay_seconds: 30, process_group_chunk: 30)

    job_grouping.separate_to_groups.each do |delay, ids|
      ids.each { |id| Delete404UrlJob.set(wait: delay.seconds).perform_later(id: id) }
    end
  end
end
