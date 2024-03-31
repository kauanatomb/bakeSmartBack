class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient
  belongs_to :measurement_unit

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :recipe_id, uniqueness: true
  validates :ingredient_id, uniqueness: true
  validates :measurement_unit_id, uniqueness: true
end