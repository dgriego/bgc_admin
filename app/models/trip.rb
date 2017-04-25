class Trip < ApplicationRecord
  has_many :child_trips
  has_many :children, through: :child_trips
end
