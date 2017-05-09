class Participant < ApplicationRecord
  has_many :particiant_trips
  has_many :trips, through: :participant_trips

  has_many :participant_users
  has_many :users, through: :participant_users

  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.disassociate_guardians
    Participant.all.each do |participant|
      participant.user_id = nil
      participant.save!
    end
  end

  def primary_trips
    ParticipantTrip.where("participant_id = ? AND participant_trips.primary = ?", self.id, true)
  end

  def alternate_trips
    ParticipantTrip.where('participant_id = ? AND participant_trips.primary = ?', self.id, false)
  end
end
