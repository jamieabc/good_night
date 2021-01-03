class User < ApplicationRecord
  has_many :sleeps

  has_many :friendships
  has_many :friends, through: :friendships

  has_many :friend_sleeps, -> { order(duration: :asc) },
           through: :friends,
           source: :sleeps

  validates :name, presence: true
end