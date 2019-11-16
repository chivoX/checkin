# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :user
  validates :checkin, :user_id, presence: true
  validate :checkout_after_checkin, if: proc { |record| record.checkout? }

  def total_worked_hours
    return nil if checkin.nil? || checkout.nil?

    ((checkout.to_time - checkin.to_time) / 1.hours).to_i
  end

  private

  def checkout_after_checkin
    if checkout < checkin
      errors.add(:checkout, 'must be after the checkin date')
    end
  end
end
