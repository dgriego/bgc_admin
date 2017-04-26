class ChildTrip < ApplicationRecord
  belongs_to :child
  belongs_to :trip

  validates :child_id, presence: true
  validates :trip_id, presence: true
end
