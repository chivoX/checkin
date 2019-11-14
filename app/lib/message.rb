# frozen_string_literal: true

class Message
  def self.not_found(record = 'record')
    "Sorry, #{record} not found."
  end

  def self.invalid_credentials
    'Invalid Credentials'
  end

  def self.invalid_token
    'Invalid Token'
  end

  def self.missing_token
    'Token not present, check your headers'
  end

  def self.unauthorized
    'Aunthorized Request'
  end

  def self.account_created
    'Account Created'
  end

  def self.account_not_created
    'Account could not be created'
  end

  def self.expired_token
    'We are sorry, but your session has expired. Login to continue.'
  end
end
