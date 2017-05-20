# == Schema Information
#
# Table name: participant_trips
#
#  id             :integer          not null, primary key
#  trip_id        :integer
#  primary        :boolean          default("true")
#  participant_id :integer
#  alternate      :boolean          default("false")
#

class ParticipantTrip < ActiveRecord::Base
  belongs_to :participant
  belongs_to :trip

  validates :participant_id, presence: true
  validates :trip_id, presence: true

  validates_uniqueness_of :participant_id, scope: :trip_id
end
