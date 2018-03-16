# Search duplicate url from ReadLater and dispatch record deletion job
class DispatchDuplicatedUrlDeletionJob < ApplicationJob
  queue_as :default

  def perform
    # Why `SELECT max(id)`? :
    # Readlater records behave as LIFO(Last-in First-out)
    # It should delete duplicate record is new one.
    # FIXME: convert code to ActiveRecord query style from raw SQL query
    select_duplicate_record_query = %(
      SELECT max(id) as id, url
      FROM read_laters
      GROUP BY url
      HAVING count(url) > 1
      ORDER by id
      LIMIT 50;
    )

    array_records = ActiveRecord::Base.connection.execute(select_duplicate_record_query)
    ids = array_records.map { |record| record['id'] }

    ids.each do |id|
      DeleteDuplicatedUrlRecordJob.perform_later(id: id)
    end
  end
end
