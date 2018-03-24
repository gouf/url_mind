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

  def self.bulk_push(markdown_list_style_urls)
    urls = extract_urls_from_markdown(markdown_list_style_urls)

    ReadLater.transaction do
      urls.each do |url|
        ReadLater.create!(url: url)
      end
    end
  end

  def self.extract_urls_from_markdown(markdown_list_style_urls)
    html = Markdown.new(markdown_list_style_urls).to_html
    links = Nokogiri::HTML(html)
    links.css('a').map { |element| element.attribute('href').value }
  end
end
