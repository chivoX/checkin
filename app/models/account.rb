# frozen_string_literal: true

# The Account model keeps User's data do avoid bloating it. Future User related
# info should be added here
class Account < ApplicationRecord
  belongs_to :user

  validates :name, :last_name, :gender, presence: true
end
