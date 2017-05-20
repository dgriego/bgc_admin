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
    users.first
  end

  def primary_trip
    participant_trips.where(primary: true).collect(&:trip).first
  end

  def alternate_trip
    participant_trips.where(primary: false).collect(&:trip).first
  end
end
