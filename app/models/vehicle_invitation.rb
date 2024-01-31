class VehicleInvitation < ApplicationRecord
  belongs_to :vehicle

  validates :code, presence: true
end
