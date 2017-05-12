# == Schema Information
#
# Table name: participant_users
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  participant_id :integer
#

class ParticipantUser < ActiveRecord::Base
  belongs_to :participant
  belongs_to :user

  validates :participant_id, uniqueness: true
end
