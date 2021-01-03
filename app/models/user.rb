class User < ApplicationRecord
  has_many :sleeps

  has_many :friendships
  has_many :friends, through: :friendships

  validates :name, presence: true
end