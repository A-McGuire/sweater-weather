module Errorable
  def registration_errors(new_user)
    return render json: {errors: 'Email has already been taken'}, status: 409 if new_user.errors.messages[:email] == ["has already been taken"]
    return render json: {errors: 'Email is required'}, status: 400 if new_user.errors.messages[:email] == ["can't be blank"]
    return render json: {errors: 'Passwords do not match'}, status: 400 if new_user.errors.messages[:password_confirmation] == ["doesn't match Password"]
    return render json: {errors: 'Password is required'}, status: 400 if new_user.errors.messages[:password] == ["can't be blank"]
  end
end