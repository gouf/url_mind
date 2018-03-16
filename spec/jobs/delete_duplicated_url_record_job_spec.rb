# frozen_string_literal: true
require 'rails_helper'

RSpec.describe DeleteDuplicatedUrlRecordJob, type: :job do
  include ActiveJob::TestHelper
  ActiveJob::Base.queue_adapter = :test

  subject(:job) { described_class.perform_later(id: 1) }

  it 'queues the job' do
    expect { job }.to have_enqueued_job(described_class)
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
