class Vehicle < ApplicationRecord
  has_many :users_vehicles
  has_many :users, through: :users_vehicles
  has_many :tickets
  has_many :vehicle_invitations

  validates :licence_plate, presence: true
  validates :province, presence: true
  validates :make, presence: true
  validates :model, presence: true
  validates :year, presence: true

  validates :licence_plate, uniqueness: { scope: :province }

  accepts_nested_attributes_for :users_vehicles

  enum province: { ontario: "ontario", quebec: "quebec" }
end
