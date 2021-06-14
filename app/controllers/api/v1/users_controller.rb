class Api::V1::UsersController < ApplicationController
  include Errorable

  def create
    user = user_params
    return render json: {errors: 'Email is required'}, status: 400 if params[:email].nil?
    user[:email] = user[:email].downcase
    new_user = User.new(user)
    if new_user.save
      render json: UsersSerializer.new(new_user), status: 201
    else
      registration_errors(new_user)
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end