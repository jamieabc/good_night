class UsersController < ApplicationController
  def follow
    friend_id = params.require(:friend_id)
    f = Friendship.new(user_id: params[:user], friend_id: friend_id)

    if f.save
      render json: success_json
      return
    end

    render json: failed_json.merge(errors: f.errors.full_messages)
  end

  def unfollow
    begin
      user_id, friend_id = params.require([:user, :friend_id])
    rescue
    #  just catch exception, either field missing should found no records
    end

    f = Friendship.find_by(user_id: user_id, friend_id: friend_id)

    if f.nil?
      render json: failed_json.merge(errors: ErrorMessage::Friend.not_friends)
      return
    end

    if f.destroy
      render json: success_json
      return
    end

    render json: failed_json.merge(errors: f.errors.full_messages)
  end
end