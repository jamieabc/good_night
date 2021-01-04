class Sleep < ApplicationRecord
  belongs_to :user
  self.ignored_columns = %w(created_at updated_at)

  validates :from, presence: true
  validates :to, presence: true
  validates :duration, presence: true

  def index
  end

  def self.list_user(user_id)
    User.find(user_id)
        .sleeps.order("created_at asc")
        .select(:from, :to, :duration)
  end
end