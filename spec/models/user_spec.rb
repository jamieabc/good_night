require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Associations" do
    it { should have_many(:friends).class_name("User") }
    it { should have_many(:sleeps) }
    it { should have_many(:friend_sleeps).class_name("Sleep") }
  end

  describe "Validations" do
    it { should validate_presence_of(:name) }
  end
end