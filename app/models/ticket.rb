class Ticket < ApplicationRecord
  belongs_to :vehicle
  has_many :users_vehicles, through: :vehicle
  has_many :users, through: :users_vehicles

  validates :vehicle, presence: true
  validates :cost, presence: true
  validates :penalty_type, presence: true
  validates :issue_date, presence: true
  validates :due_date, presence: true

  enum penalty_type: { parking: "parking", speeding: "speeding" }
  enum status: { paid: "paid", pending: "pending", in_dispute: "in_dispute", cancelled: "cancelled"}
end
