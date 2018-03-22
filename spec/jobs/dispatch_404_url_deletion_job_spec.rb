# frozen_string_literal: true

require 'rails_helper'

require File.join(__dir__, '..', '..', 'app', 'jobs', 'dispatch_404_url_deletion_job')

RSpec.describe Dispatch404UrlDeletionJob, type: :job do
  include ActiveJob::TestHelper
  ActiveJob::Base.queue_adapter = :test

  context 'when enqueue job' do
    subject(:job) { described_class.perform_later }

    it 'queues the job' do
      expect { job }.to have_enqueued_job(described_class)
    end

    after do
      clear_enqueued_jobs
      clear_performed_jobs
    end
  end
end
