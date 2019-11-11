# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :user
  validates :checkin, :user_id, presence: true

  def total_worked_hours
    ((checkout.to_time - checkin.to_time) / 1.hours).to_i
  end
end
