class ReadLater < ApplicationRecord
  before_save :decode_as_raw_url

  # Decode to type of URL
  # @return [String]
  def decode_as_raw_url
    self.url = URI.decode_www_form_component(url)
  end

  # Find and return first record, then delete it.
  # @return [Readlater, nil]
  def self.pop!
    first&.destroy
  end
end
