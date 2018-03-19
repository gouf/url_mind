# frozen_string_literal: true
require 'rails_helper'

RSpec.describe DispatchUnshortenUrlJob, type: :job do
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

    before do
      ReadLater.create(url: 'https://t.co/lkmoGRJnqK?ssr=true')
      perform_enqueued_jobs do
        DispatchUnshortenUrlJob.perform_later
      end
    end

    it 'has unshorten url' do
      expect(ReadLater.first.url).to eq 'http://qiita.com/jnchito/items/ec04537b352123cab288'
    end

    after do
      clear_enqueued_jobs
      clear_performed_jobs
      ReadLater.destroy_all
    end
  end
end
