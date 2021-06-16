class ErrorFacade
  class << self
    def registration_errors(new_user)
      if new_user.errors.messages[:email] == ['has already been taken']
        return { errors: 'Email has already been taken' }
      elsif new_user.errors.messages[:email] == ["can't be blank"]
        return { errors: 'Email is required' }
      elsif new_user.errors.messages[:password_confirmation] == ["doesn't match Password"]
        return { errors: 'Passwords do not match' }
      elsif new_user.errors.messages[:password] == ["can't be blank"]
        { errors: 'Password is required' }
      end
    end
  end
end