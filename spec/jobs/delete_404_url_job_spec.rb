# frozen_string_literal: true

require 'rails_helper'

require File.join(__dir__, '..', '..', 'app', 'jobs', 'delete_404_url_job')

RSpec.describe Delete404UrlJob, type: :job do
  include ActiveJob::TestHelper
  ActiveJob::Base.queue_adapter = :test

  context 'when enqueue job' do
    subject(:job) { described_class.perform_later(id: 1) }

    it 'queues the job' do
      expect { job }.to have_enqueued_job(described_class)
    end

    after do
      clear_enqueued_jobs
      clear_performed_jobs
    end
  end

  context 'after perform' do
    before do
      ReadLater.create(url: 'http://www.example.com/foo/bar') # HTTP 404 URL
      ReadLater.create(url: 'http://www.example.com/')

      perform_enqueued_jobs do
        Delete404UrlJob.perform_later(id: ReadLater.first.id)
      end
    end

    it 'remain 1 record' do
      expect(ReadLater.count).to eq 1
    end

    after do
      clear_enqueued_jobs
      clear_performed_jobs

      ReadLater.destroy_all
    end
  end
end
