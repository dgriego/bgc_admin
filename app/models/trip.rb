# == Schema Information
#
# Table name: trips
#
#  id         :integer          not null, primary key
#  title      :string
#  location   :string
#  seats      :integer
#  alt_seats  :integer
#  start_date :date
#  start_time :time
#  end_time   :time
#  published  :boolean          default("false")
#

class Trip < ActiveRecord::Base
  MAX_SEATS = 60
  MAX_ALT_SEATS = 30

  has_many :participant_trips
  has_many :participants, through: :participant_trips

  validates :title, presence: true
  validates :alt_seats, presence: true
  validates :seats, presence: true
  validates :start_date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  scope :published, -> { where(published: true) }

  def self.max_seats
    (1..MAX_SEATS).to_a
  end

  def self.max_alt_seats
    (1..MAX_ALT_SEATS).to_a
  end

  def seats_left
    self.seats - self.participants.count
  end

  def alternate_seats_left
  end
end
