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

puts "Cleaning DB..."
Category.destroy_all
MeasurementUnit.destroy_all
User.destroy_all

puts "Creating categories..."
categories = ["Fruits", "Drinks", "Vegetables", "Frozen Foods", "Canned Foods", "Dairy", "Meat", "Bakery", "Cleaning", "Packaging", "Spices & Herbs", "Grains & Cereals", "Sweets", "Snacks", "Others"]
categories.each do |name|
  Category.create!(name: name)
end

puts "Criando unidades de medida..."
units = [
  { name: "Kilogram", symbol: "kg" },
  { name: "Gram", symbol: "g" },
  { name: "Liter", symbol: "l" },
  { name: "Milliliter", symbol: "ml" }
]

units.each do |unit|
  MeasurementUnit.create!(unit)
end

puts "Creating users..."
User.create!(
  name: "Regular User",
  email: "regular@example.com",
  password: "password123",
  role: 0
)

User.create!(
  name: "Administrator",
  email: "admin@example.com",
  password: "password123",
  role: 1
)

puts "Seeds created successfully!"