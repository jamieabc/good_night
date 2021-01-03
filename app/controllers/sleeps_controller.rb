class SleepsController < ApplicationController
  before_action :find_user

  def create
    user_id, from, to = params.require([:user, :from, :to])
    from, to = Time.parse(from), Time.parse(to)

    if from >= to
      return render json: { error: 'sleep time incorrect, from should be earlier than to' }
    end

    Sleep.create(user_id: user_id, from: from, to: to, duration: to - from)

    render json: { message: Sleep.list_user(user_id) }
  end

  def list_friends
    render json: {
      message: @user.friend_sleeps
                    .group_by { |u| u.user_id}
    }
  end

  private

  def find_user
    if params[:user].blank?
      return render json: { error: 'user id not exist' }
    end

    begin
      @user = User.find(params[:user])
    rescue
      render json: { error: 'user not exist' }
    end
  end
end