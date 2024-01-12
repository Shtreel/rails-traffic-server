class MapMarker < ApplicationRecord
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :name, presence: true

  enum icon_type: { redlight: "redlight", speedtrap: "speedtrap" }
end
