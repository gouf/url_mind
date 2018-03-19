namespace :job do
  desc "Delete ReadLater record that duplicate URL"
  task dispatch_duplicated_url_deletion: :environment do
    DispatchDuplicatedUrlDeletionJob.perform_now
  end

  desc "Find shoten-URL and update to unshorten-URL"
  task dispatch_url_unshorten: :environment do
    DispatchUnshortenUrlJob.perform_now
  end
end
