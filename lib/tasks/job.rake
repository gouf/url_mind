namespace :job do
  desc "Delete ReadLater record that duplicate URL"
  task dispatch_duplicated_url_deletion: :environment do
    DispatchDuplicatedUrlDeletionJob.perform_now
  end
end
