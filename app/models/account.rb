class Account < ApplicationRecord
  belongs_to :user

  validates :name, :last_name, :gender, presence: true
end
