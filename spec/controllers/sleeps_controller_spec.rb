require 'rails_helper'

RSpec.describe SleepsController, type: :request do
  invalid_user_id = 100
  fixtures :users

  describe "#before_action" do
    it "error if user not exist" do
      get '/sleeps/friends', params: { user: invalid_user_id }

      expect(JSON.parse(response.body)["error"]).to be_truthy
    end
  end

  describe "Post #create" do
    it "error if wrong time format" do
      user = User.find(1)

      post '/sleeps', params: {
        user: user.id,
        from: "from",
        to: "to"
      }

      expect(JSON.parse(response.body)["error"]).to be_truthy
    end

    it "error if sleep start time later than end time" do
      user = User.find(1)

      post '/sleeps', params: {
        user: user.id,
        from: Time.now - 8.hour,
        to: Time.now - 16.hour,
      }

      expect(JSON.parse(response.body)["error"]).to be_truthy
    end

    it "return sleep time order by creation" do
      user = User.find(1)

      later_sleep = Sleep.create(
        user_id: user.id,
        from: Time.now - 16.hour,
        to: Time.now - 8.hour,
        duration: 12345,
        created_at: Time.now + 1.hour
      )
      size = user.sleeps.size

      post '/sleeps', params: {
        user: user.id,
        from: Time.now - 28.hour,
        to: Time.now - 20.hour
      }

      resp = JSON.parse(response.body)

      expect(resp["message"].size).to be(size + 1)
      expect(resp["message"][1]["duration"]).to be(later_sleep.duration)
    end
  end

  describe "Get #list_friends" do
    it "return friends last week sleep time by duration" do
      user1, user2 = User.find(1), User.find(2)
      now = Time.now

      Sleep.create(user_id: user2.id, from: now-10.days, to: now-9.days, duration: 1.day)
      Sleep.create(user_id: user2.id, from: now - 8.hour, to: now - 1.hour, duration: 1.hour)
      Sleep.create(user_id: user2.id, from: now - 8.hour, to: now, duration: 8.hour)
      Friendship.create(user_id: user1.id, friend_id: user2.id)
      original_size = User.find(user1.id).friend_sleeps.size

      get '/sleeps/friends', params: { user: user1.id }
      resp = JSON.parse(response.body)

      expect(resp["message"][user2.id.to_s].size).to be(original_size-1)
      expect(resp["message"][user2.id.to_s][0]["duration"]).to be(1.hour.to_i)
      expect(resp["message"][user2.id.to_s][1]["duration"]).to be(8.hour.to_i)
    end
  end
end