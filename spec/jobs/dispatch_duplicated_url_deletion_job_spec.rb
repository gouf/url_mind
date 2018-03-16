require 'rails_helper'

RSpec.describe DispatchDuplicatedUrlDeletionJob, type: :job do
  include ActiveJob::TestHelper
  ActiveJob::Base.queue_adapter = :test

  context 'enqueued' do
    subject(:job) { described_class.perform_later }

    it 'queues the job' do
      expect { job }.to have_enqueued_job(described_class)
    end

    after do
      clear_enqueued_jobs
      clear_performed_jobs
    end
  end

  context 'after performed' do
    let(:duplicate_records_count) { 3 }

    before do
      duplicate_records_count.times do
        ReadLater.create(url: 'http://example.com')
      end

      perform_enqueued_jobs do
        DispatchDuplicatedUrlDeletionJob.perform_later
      end
    end

    it 'delete 1 record' do
      expect(ReadLater.count).to eq (duplicate_records_count - 1)
    end

    after do
      clear_enqueued_jobs
      clear_performed_jobs
      ReadLater.destroy_all
    end
  end
end
