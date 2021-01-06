class SleepsController < ApplicationController
  before_action :find_user

  def create
    user_id, from, to = params.require([:user, :from, :to])
    from, to = Time.parse(from), Time.parse(to)

    if from >= to
      render json: { error: ErrorMessage::Sleep.invalid_from }
      return
    end

    Sleep.create(user_id: user_id, from: from, to: to, duration: to - from)

    render json: { message: Sleep.list_user(user_id) }
  end

  def list_friends
    render json: {
      message: @user.friend_sleeps
                    .week_earlier
                    .group_by { |u| u.user_id }
    }
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