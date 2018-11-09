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
  context 'saving record' do
    it 'has decoded url' do
      ReadLater.create(url: 'http%3A%2F%2Fexample.com')
      expect(ReadLater.first.url).to eq 'http://example.com'
    end

    after(:each) { ReadLater.destroy_all }
  end

  context 'pop when records is empty' do
    subject { ReadLater.pop! }

    it { is_expected.to be_nil }
  end
end
