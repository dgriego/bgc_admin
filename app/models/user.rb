class User < ApplicationRecord
  has_many :role_users
  has_many :roles, through: :role_users
  has_many :children

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

  def username
    self.first_name << ' ' << self.last_name
  end
end
