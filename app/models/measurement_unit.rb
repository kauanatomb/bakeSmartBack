class MeasurementUnit < ApplicationRecord
  has_many :ingredients
  validates :name, presence: true, uniqueness: true
  validates :symbol, presence: true, uniqueness: true
end
