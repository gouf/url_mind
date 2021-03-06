# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env.development?
  ReadLater.destroy_all
  50.times do |i|
    url = 'https://www.example.com/'
    ReadLater.create!(
      title: "some of title #{i}",
      url: "#{url}#{i}"
    )
  end
end
