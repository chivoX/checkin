# frozen_string_literal: true

class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end

  # Service entry point
  def call
    {
      auth_token: token,
      user_type: user.class.name,
      user_name: user.full_name,
      user_id: user.id
    }
  end

  private

  attr_reader :email, :password

  def token
    JsonWebToken.encode(user_id: user.id, user_type: user.class.name) if user
  end

  # verify user credentials
  def user
    user = User.find_by(email: email) || Admin.find_by(email: email)
    return user if user&.authenticate(password)

    # raise Authentication error if credentials are invalid
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end
