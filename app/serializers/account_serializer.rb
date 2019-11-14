# frozen_string_literal: true

class AccountSerializer
  include FastJsonapi::ObjectSerializer
  belongs_to :user

  attributes :id, :first_name, :last_name, :gender
end
