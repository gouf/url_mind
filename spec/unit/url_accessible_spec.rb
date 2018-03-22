# frozen_string_literal: true

require 'url_accessible' # lib/url_accessible

describe UrlAccessible do
  context 'When URL has exist' do
    it 'gets false (200 OK)' do
      url = 'http://www.example.com/'
      expect(UrlAccessible.not_found?(url)).to be_falsy
    end
  end

  context 'When URL has not exist' do
    it 'gets true (404 NG)' do
      url = 'http://www.example.com/foo/bar'
      expect(UrlAccessible.not_found?(url)).to be_truthy
    end
  end
end
