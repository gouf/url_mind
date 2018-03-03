require 'rails_helper'

RSpec.describe ReadLater, type: :model do
  context 'saving record' do
    it 'has decoded url' do
      ReadLater.create(url: 'http%3A%2F%2Fexample.com')
      expect(ReadLater.first.url).to eq 'http://example.com'
    end

    after(:each) { ReadLater.destroy_all }
  end
end
