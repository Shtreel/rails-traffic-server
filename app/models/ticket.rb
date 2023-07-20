class Ticket < ApplicationRecord
  validates :vehicle, presence: true
  validates :cost, presence: true
  validates :penalty_type, presence: true
  validates :issue_date, presence: true
  validates :due_date, presence: true

  belongs_to :vehicle

  enum penalty_type: [:parking]
end
