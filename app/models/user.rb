class User < ApplicationRecord
  has_many :user_vehicles
  validates :firebase_id, uniqueness: true
  validates :firebase_id, presence: true
  validates :name, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
end
