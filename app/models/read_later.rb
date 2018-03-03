class ReadLater < ApplicationRecord
  before_save :decode_as_raw_url

  def decode_as_raw_url
    self.url = URI.decode_www_form_component(url)
  end

  def self.pop!
    first&.destroy
  end
end
