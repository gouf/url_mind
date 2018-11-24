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

require 'rails_helper'

RSpec.describe ReadLater, type: :model do
  let(:markdown_text) do
    _ = <<-MARKDOWN.strip
      [title A](http://example.com)
      [title B](http://example.com)
    MARKDOWN
  end

  context 'saving record' do
    let(:record) do
      ReadLater.create!(
        title: 'test record title',
        url: 'http%3A%2F%2Fexample.com'
      )
    end

    it 'has decoded url' do
      expect(record.url).to eq 'http://example.com'
    end

    it 'has title' do
      ReadLater.bulk_push(markdown_text)
      expect(ReadLater.first.title).to eq 'title A'
    end

    after(:each) { ReadLater.destroy_all }
  end

  context 'pop when records is empty' do
    subject { ReadLater.pop! }

    it { is_expected.to be_nil }
  end

  context 'and markdown text data' do
    it 'can get urls' do
      urls = ReadLater.extract_urls_from_markdown(markdown_text)
      expect(urls).to match (['http://example.com'] * 2)
    end

    it 'can get title' do
      titles = ReadLater.extract_titles_from_markdown(markdown_text)
      expect(titles).to match %w[title\ A title\ B]
    end
  end
end
