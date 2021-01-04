require 'rails_helper'

RSpec.describe UsersController, type: :request do
  invalid_user_id = 100

  describe "#before_action" do
    it "error if user not exist" do
      post '/users/friends/1', params: { user: invalid_user_id }

      expect(JSON.parse(response.body)["error"]).to be_truthy
    end

    it "error if friend not exist" do
      user = User.find(1)

      post "/users/friends/#{invalid_user_id}", params: { user: user.id }
      expect(JSON.parse(response.body)["error"]).to be_truthy
    end
  end

  describe "Post #follow" do
    it "follows friend" do
      user1 = User.create(name: "test1")
      User.create(name: "test2")
      orig_friend_size = user1.friends.size

      post '/users/friends/2', params: { user: user1.id }

      resp = JSON.parse(response.body)
      expect(resp["message"]).to be_truthy

      expect(User.find(user1.id).friends.size).to be(orig_friend_size + 1)
    end
  end

  describe "Post #unfollow" do
    it "removes friends" do
      user1, user2 = User.find(8), User.find(9)
      Friendship.create(user_id: user1.id, friend_id: user2.id)

      orig_friend_size = User.find(user1.id).friends.size

      delete "/users/friends/#{user2.id}", params: { user: user1.id }

      resp = JSON.parse(response.body)
      expect(resp["message"]).to be_truthy

      expect(User.find(user1.id).friends.size).to be(orig_friend_size - 1)
    end
  end
end