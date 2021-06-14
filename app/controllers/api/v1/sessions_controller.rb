class Api::V1::SessionsController < ApplicationController
  def create
    return render json: {errors: 'Email is required'}, status: 400 if params[:email].nil?
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render json: UsersSerializer.new(user), status: 200
    else
      render json: {errors: 'Invalid user credentials'}, status: 400
    end
  end
end