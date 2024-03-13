class Ticket < ApplicationRecord
  belongs_to :vehicle
  has_many :users_vehicles, through: :vehicle
  has_many :users, through: :users_vehicles
  has_many :payments, dependent: :destroy

  validates :vehicle, presence: true
  validates :cost, presence: true
  validates :penalty_type, presence: true
  validates :issue_date, presence: true
  validates :due_date, presence: true

  enum penalty_type: { parking: "parking", speeding: "speeding", redlight: "redlight" }
  enum status: { paid: "paid", pending: "pending", in_dispute: "in_dispute", cancelled: "cancelled"}
end
