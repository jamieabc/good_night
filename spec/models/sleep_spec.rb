require 'rails_helper'

RSpec.describe Sleep, type: :model do
  describe "Associations" do
    it { should belong_to(:user) }
  end

  describe "Validations" do
    it { should validate_presence_of(:from) }
    it { should validate_presence_of(:to) }
    it { should validate_presence_of(:duration) }
  end
end