class Ingredient < ApplicationRecord
  belongs_to :category
  belongs_to :measurement_unit
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  validates :name, presence: true, uniqueness: true
  validates :category_id, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :measurement_unit_id, presence: true
end
