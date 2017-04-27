class Trip < ApplicationRecord
  has_many :child_trips
  has_many :children, through: :child_trips

  validates :title, presence: true
  validates :location, presence: true
  validates :seats, presence: true
  validates :alt_seats, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
end
