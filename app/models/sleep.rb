class Sleep < ApplicationRecord
  belongs_to :user

  validates :from, presence: true
  validates :to, presence: true
  validates :duration, presence: true

  scope :week_earlier, -> { where("sleeps.from between ? and ?",
                                  Time.now-7.day, Time.now) }

  def index
  end

  def self.list_user(user_id)
    User.find(user_id)
        .sleeps.order("created_at asc")
        .select(:from, :to, :duration)
  end
end