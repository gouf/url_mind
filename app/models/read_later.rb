# frozen_string_literal: true
# == Schema Information
#
# Table name: read_laters
#
#  id         :integer          not null, primary key
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Manage the read later records
class ReadLater < ApplicationRecord
  before_save :decode_as_raw_url

  # Decode to type of URL
  # @return [String]
  def decode_as_raw_url
    self.url = URI.decode_www_form_component(url)
  end

  # Delete first record
  # @return [Readlater, nil]
  def self.pop!
    first&.destroy
  end

  # Save to records for multiple Markdown list style URLs
  # @param markdown_list_style_urls [String] the Markdown list style URLs
  def self.bulk_push(markdown_list_style_urls)
    titles = extract_titles_from_markdown(markdown_list_style_urls)
    urls = extract_urls_from_markdown(markdown_list_style_urls)

    ReadLater.transaction do
      [titles, urls].transpose.each do |title, url|
        ReadLater.create!(
          title: title,
          url: url
        )
      end
    end
  end

  # Extract URLs from Markdown style list
  # @param markdown_list_style_urls [String] the Markdown list style URLs
  # @return [Array<String>] Array of URL string
  # @example Markdown style list to URL
  #   Readlater.extract_urls_from_markdown('* [example](http://www.example.com/)')
  #   # => ['http://www.example.com/']
  def self.extract_urls_from_markdown(markdown_list_style_urls)
    html = Markdown.new(markdown_list_style_urls).to_html
    links = Nokogiri::HTML(html)
    links.css('a').map { |element| element.attribute('href').value }
  end

  def self.extract_titles_from_markdown(markdown_list_style_urls)
    html = Markdown.new(markdown_list_style_urls).to_html
    links = Nokogiri::HTML(html)
    links.css('a').map(&:text)
  end
end
