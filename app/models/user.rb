# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_one :account, dependent: :destroy
  has_many :events, dependent: :destroy
  accepts_nested_attributes_for :account, allow_destroy: true

  # validates_presence_of :email, :password_digest
  validates_uniqueness_of :email
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 8 },
    allow_nil: true, on: :create

  scope :by_name, ->(name) { joins(:account).where('accounts.name = ?', name) }
  scope :by_last_name, ->(last_name) { joins(:account).where('accounts.last_name = ?', last_name) }
  scope :by_email, ->(email) { where(email: email) }
  scope :by_gender, ->(gender) { joins(:account).where('accounts.gender = ?', gender) }

  def full_name
    "#{account.name.capitalize} #{account.last_name.capitalize}"
  end
end
