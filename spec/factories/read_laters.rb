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


FactoryBot.define do
  factory :read_later do
    url 'MyString'
  end
end
