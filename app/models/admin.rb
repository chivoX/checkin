# frozen_string_literal: true

class Admin < ApplicationRecord
  has_secure_password

  validates_presence_of :password_digest
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password, presence: true, length: { minimum: 8 },
    allow_nil: true, on: :create
  def full_name
    email
  end

end
