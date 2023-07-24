class User < ApplicationRecord
  has_many :users_vehicles
  has_many :vehicles, through: :users_vehicles
  has_many :tickets, through: :vehicles

  validates :firebase_id, uniqueness: true
  validates :firebase_id, presence: true
  validates :name, presence: true
  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :drivers_licence_number, uniqueness: true
  validates :drivers_licence_number, presence: true
end
