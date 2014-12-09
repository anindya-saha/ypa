# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#Event.create!(name:  "Dummy Event", desc: "Dummy Description", from_date: Date.today + 10, to_date: Date.today + 11, venue: "Some Venue", min_before_start: 10, max_before_end: 30, deleted: false)
#Category.create!(name:  "Dummy Category", desc: "Dummy Description", deleted: false)

require 'date'
require 'time'

User.create!(email: "admin@test.com", first_name: "admin", last_name: "admin", dob: Date.today - 10000, phone: 1234567890, volunteer: true, donate: true, admin: true, password: "test1234", encrypted_password: "$2a$10$Iah.R3jPayi3.9s5iCNdd.8fC4DqbiBF7QIadcWWqSVaMPz0FUwk.")
User.create!(email: "test@test.com", first_name: "test", last_name: "test", dob: Date.today - 15000, phone: 9834567890, volunteer: false, donate: true, admin: false, password: "test1234", encrypted_password: "$2a$10$Iah.R3jPayi3.9s5iCNdd.8fC4DqbiBF7QIadcWWqSVaMPz0FUwk.")

5.times do |n|
  name  = "Category-#{n+1}"
  
  chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ23456789'
  desc = ''
  3.times do |i|
	desc << ' '
	rand(10...20).times { |j| desc << chars[rand(chars.length)] }
  end
  
  Category.create!(name: name, desc: desc, deleted: false)
end


99.times do |n|
  name  = "Event-#{n+1}"
  
  chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ23456789'
  desc = ''
  3.times do |i|
	desc << ' '
	rand(10...20).times { |j| desc << chars[rand(chars.length)] }
  end
  
  from_date = Date.today + Random.new.rand(1...10)
  to_date = from_date + Random.new.rand(1...5)

  from_time_hour =  Random.new.rand(1...10)
  from_time_min =  Random.new.rand(1...40)
  
  # from_time = Time.at(0)
  from_time = Time.mktime(from_date.year, from_date.month, from_date.day, from_time_hour, from_time_min)

  # to_time = Time.at(100)
  to_time = Time.mktime(to_date.year, to_date.month, to_date.day, from_time_hour+2, from_time_min+10 )
	
  venue = ''
  rand(5...10).times { |j| venue << chars[rand(chars.length)] }
  
  category_id = Random.new.rand(1...5)
  
  min_before_start = Random.new.rand(10...30)
  max_before_end = Random.new.rand(30...60)

  Event.create!(name:  name, desc: desc, from_date: from_date, to_date: to_date, from_date: from_date, to_date: to_date, from_time: from_time, to_time: to_time, venue: venue, min_before_start: min_before_start, max_before_end: max_before_end, category_id: category_id, deleted: false)
end


