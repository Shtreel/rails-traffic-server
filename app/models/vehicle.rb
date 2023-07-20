class Vehicle < ApplicationRecord
  has_many :tickets
  validates :licence_plate, uniqueness: true
  validates :make, presence: true
  validates :model, presence: true
  validates :year, presence: true
end
