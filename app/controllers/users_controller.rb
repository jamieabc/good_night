class UsersController < ApplicationController
  before_action :find_user

  def follow
    friend_id = params.require(:friend_id)
    f = Friendship.new(user_id: @user.id, friend_id: friend_id)

    unless f.valid?
      return render json: { error: ErrorMessage::Friend.invalid }
    end

    f.save
    render json: { message: 'ok' }
  end

  def unfollow
    friend_id = params.require(:friend_id)
    f = Friendship.find_by(user_id: @user.id, friend_id: friend_id)

    if f.nil?
      return render json: { error: ErrorMessage::Friend.not_friends }
    end

    f.destroy

    render json: { message: 'ok' }
  end

  private

  def find_user
    if params[:user].blank?
      return render json: { error: ErrorMessage::User.id_not_exist }
    end

    begin
      @user = User.find(params[:user])
    rescue
      render json: { error: ErrorMessage::User.not_exist }
    end
  end
end