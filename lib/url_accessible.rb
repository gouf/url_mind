# frozen_string_literal: true

require 'uri'
require 'net/http'

# Is that url accessible?
module UrlAccessible
  def self.not_found?(url_string)
    uri = ::URI.parse(url_string)
    response = ::Net::HTTP.get_response(uri)

    response.code.to_i.eql?(404)
  end
end
