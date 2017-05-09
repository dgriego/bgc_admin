class Trip < ApplicationRecord
  has_many :participants
  has_many :participants, through: :participant_trips

  validates :title, presence: true
  validates :location, presence: true
  validates :seats, presence: true
  validates :alt_seats, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
end
