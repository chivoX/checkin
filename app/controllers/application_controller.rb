# frozen_string_literal: true

require 'will_paginate/array'

class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include Response
  include ExceptionHandler

  # called before every action on controllers
  before_action :authorize_request
  attr_reader :current_user

  private

  def admin?
    raise ExceptionHandler::AuthenticationError if current_user.is_a?(User)

    true
  end

  # Check for valid request token and return user
  def authorize_request
    @current_user = AuthorizeApiRequest.new(request.headers).call[:user]
  end
end
