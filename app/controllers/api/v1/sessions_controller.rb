class Api::V1::SessionsController < ApplicationController
  def create
    return render json: { errors: 'Email is required' }, status: :bad_request if params[:email].nil?
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render json: UsersSerializer.new(user), status: :ok
    else
      render json: { errors: 'Invalid user credentials' }, status: :bad_request
    end
  end
end
