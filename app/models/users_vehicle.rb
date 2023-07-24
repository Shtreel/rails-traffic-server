class UsersVehicle < ApplicationRecord
	belongs_to :user
	belongs_to :vehicle
	
	has_many :tickets, through: :vehicle

  validates :user_id, uniqueness: { scope: :vehicle_id }
end
