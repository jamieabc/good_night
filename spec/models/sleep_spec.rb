require 'rails_helper'

RSpec.describe Sleep, type: :model do
  invalid_user = 100

  describe "Associations" do
    it { should belong_to(:user) }
  end

  describe "Validations" do
    it { should validate_presence_of(:from) }
    it { should validate_presence_of(:to) }
    it { should validate_presence_of(:duration) }
    it { should validate_numericality_of(:duration).is_greater_than(0) }
    it { should validate_numericality_of(:duration).is_less_than(16.hour.to_i) }

    it "validates user exist" do
      s = Sleep.new(user_id: invalid_user, from: Time.now - 8.hour, to: Time.now,
                    duration: 8.hour)
      expect(s).to be_invalid
    end
  end
end