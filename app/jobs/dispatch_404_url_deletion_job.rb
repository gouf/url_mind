# frozen_string_literal: true

# Search 404 response URL and dispatch deletion
class Dispatch404UrlDeletionJob < ApplicationJob
  queue_as :default

  DELAY_SECONDS = 30
  PROCESS_GROUP_CHUNK = 30

  def perform
    # split records into group by chunk size
    process_group = ReadLater.all.map(&:id).each_slice(0.step(ReadLater.count, PROCESS_GROUP_CHUNK).size).lazy
    # => [[2, 4, 8, ...], [128, 256, 512, ...], ...]

    delay_group = Array.new(process_group.size, nil).inject([]) { |ret, _| ret << ret.last.to_i + DELAY_SECONDS }.lazy
    # => [30, 60, 90, 120, ...]

    delay_group.zip(process_group).each do |delay, ids|
    # => [
    #   [30, [128, 256, 512, ...]],
    #   [60, [2, 4, 8, ...]],
    #   ...,
    # ]
      ids.each { |id| Delete404UrlJob.set(wait: delay.seconds).perform_later(id: id) }
    end
  end
end
