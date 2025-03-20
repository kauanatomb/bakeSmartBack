# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

puts "Creating categories..."
categories = [
  "Fruits", "Drinks", "Vegetables", "Frozen Foods", "Canned Foods", "Dairy", 
  "Meat", "Bakery", "Cleaning", "Packaging", "Spices & Herbs", "Grains & Cereals", 
  "Sweets", "Snacks", "Others"
]
categories.each do |name|
  Category.find_or_create_by!(name: name)
end

puts "Creating measurement units..."
units = [
  { name: "Kilogram", symbol: "kg" },
  { name: "Gram", symbol: "g" },
  { name: "Liter", symbol: "l" },
  { name: "Milliliter", symbol: "ml" }
]
units.each do |unit|
  MeasurementUnit.find_or_create_by!(name: unit[:name], symbol: unit[:symbol])
end

puts "Creating users..."
User.find_or_create_by!(email: "regular@example.com") do |user|
  user.name = "Regular User"
  user.password = "password123"
  user.role = 0
end

User.find_or_create_by!(email: "admin@example.com") do |user|
  user.name = "Administrator"
  user.password = "password123"
  user.role = 1
end

puts "Seeds created successfully!"
