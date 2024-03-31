class Recipe < ApplicationRecord
  has_many :ingredients, through: :recipe_ingredients
  has_many :recipe_ingredients

  validates :name, presence: true
  validates :description, presence: true

  accepts_nested_attributes_for :recipe_ingredients
end