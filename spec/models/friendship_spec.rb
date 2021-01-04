require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:friend).class_name('User') }
  end

  describe "Validations" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:friend_id) }
  end
end