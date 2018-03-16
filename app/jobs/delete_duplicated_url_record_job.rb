# frozen_string_literal: true

# Delete ReadLater record (receive order from DispatchDuplicatedUrlDeletionJob)
class DeleteDuplicatedUrlRecordJob < ApplicationJob
  queue_as :default

  def perform(*args)
class DeleteDuplicatedUrlRecordJob < ApplicationJob
  queue_as :default

  def perform(**args)
    ReadLater.destroy(args[:id])
  end
end
