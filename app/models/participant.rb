# == Schema Information
#
# Table name: participants
#
#  id         :integer          not null, primary key
#  first_name :string
#  age        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  last_name  :string
#

class Participant < ActiveRecord::Base
  has_many :participant_trips
  has_many :trips, through: :participant_trips

  has_many :participant_users
  has_many :users, through: :participant_users

  validates :first_name, presence: true
  validates :last_name, presence: true

  def guardian
    self.users.first
  end

  def primary_trips
    ParticipantTrip.where("participant_id = ? AND participant_trips.primary = ?", self.id, true)
  end

  def alternate_trips
    ParticipantTrip.where('participant_id = ? AND participant_trips.primary = ?', self.id, false)
  end
end
