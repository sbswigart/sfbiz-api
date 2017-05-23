# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# biz1 = Business.create(name: 'Biz 1')
# biz2 = Business.create(name: 'Biz 2')
# biz3 = Business.create(name: 'Biz 3')

require 'csv'

CSV.foreach('./db/seed-example.csv', :headers => true) do |row|
  r = row.to_hash
  b = {}
  b[:name] = r["DBA Name"]
  b[:address] = r["Street Address"]
  b[:start_date] = r["Business Start Date"]
  b[:end_date] = r["Business End Date"]

  ll = r["Business Location"]
  unless ll.nil?
    ll = ll.match(/\((?<lat>\d+\.\d+),.(?<long>-\d+\.\d+)/)
    unless ll.nil?
      unless ll[:lat].nil? && ll[:long].nil?
        b[:lat] = ll[:lat].to_f
        b[:long] = ll[:long].to_f
      end
    end
  end

  Business.create!(b)
end

b = Business.find(1)
Favorite.create!(business: b)
