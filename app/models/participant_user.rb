class ParticipantUser < ApplicationRecord
  belongs_to :participant
  belongs_to :user

  validates :participant_id, uniqueness: true
end
