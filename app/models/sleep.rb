class Sleep < ApplicationRecord
  belongs_to :user

  def index
  end

  def self.list_user(user_id)
    User.find(user_id)
        .sleeps.order("created_at asc")
        .select(:from, :to, :duration)
  end
end