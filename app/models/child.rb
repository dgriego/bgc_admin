class Child < ApplicationRecord
  belongs_to :user
  has_many :child_trips
  has_many :trips, through: :child_trips

  def primary_trips
    ChildTrip.where("child_id = ? AND child_trips.primary = ?", self.id, true)
  end

  def alternate_trips
    ChildTrip.where('child_id = ? AND child_trips.primary = ?', self.id, false)
  end
end
