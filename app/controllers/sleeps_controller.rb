class SleepsController < ApplicationController
  def create
    begin
      user_id, from, to = params.require([:user, :from, :to])
    rescue ActionController::ParameterMissing => e
      render json: { error: e.to_s }
      return
    end

    begin
      from, to = Time.parse(from), Time.parse(to)
    rescue ArgumentError => e
      render json: failed_json.merge(errors: e.to_s)
      return
    end

    sleep = Sleep.new(user_id: user_id, from: from, to: to, duration: to - from)
    if sleep.save
      render json: { message: Sleep.list_user(user_id) }
      return
    end

    render json: failed_json.merge(errors: sleep.errors)
  end

  def list_friends
    user = User.find(params[:user])

    if user.nil?
      render json: failed_json.merge(errors: ErrorMessage::User.not_exist)
      return
    end

    render json: success_json.merge({
                                      friends: user.friend_sleeps
                                                  .week_earlier
                                                  .group_by { |u| u.user_id }
                                    })
  end
end