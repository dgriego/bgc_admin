class ParticipantTrip < ApplicationRecord
  belongs_to :participant
  belongs_to :trip

  validates :participant_id, presence: true
  validates :trip_id, presence: true
end
