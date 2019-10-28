module Request
  module AuthHelpers
    def auth_headers(user)
      auth_hash = AuthenticateUser.new(user.email, '123456789').call
        auth_hash[:auth_token]
    end
  end
end
