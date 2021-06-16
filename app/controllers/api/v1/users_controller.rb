class Api::V1::UsersController < ApplicationController
  def create
    user = user_params
    return render json: { errors: 'Email is required' }, status: :bad_request if params[:email].nil?

    user[:email] = user[:email].downcase
    new_user = User.new(user)
    if new_user.save
      render json: UsersSerializer.new(new_user), status: :created
    else
      render json: ErrorFacade.registration_errors(new_user), status: :bad_request
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  # def registration_errors(new_user)
  #   if new_user.errors.messages[:email] == ['has already been taken']
  #     return render json: { errors: 'Email has already been taken' },
  #                   status: :conflict
  #   end
  #   if new_user.errors.messages[:email] == ["can't be blank"]
  #     return render json: { errors: 'Email is required' },
  #                   status: :bad_request
  #   end
  #   if new_user.errors.messages[:password_confirmation] == ["doesn't match Password"]
  #     return render json: { errors: 'Passwords do not match' },
  #                   status: :bad_request
  #   end
  #   if new_user.errors.messages[:password] == ["can't be blank"]
  #     render json: { errors: 'Password is required' },
  #            status: :bad_request
  #   end
  # end
end
