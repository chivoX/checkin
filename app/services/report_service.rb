# frozen_string_literal: true

class ReportService
  attr_reader :limit

  def initialize(limit:)
    @limit = limit
  end

  def perform
    limit_report_data
  end

  private

  def limit_report_data
    User.includes(:events).limit(limit).map do |user|
      ReportResult.new(
        id: SecureRandom.hex(2),
        email: user.email,
        total_worked_hours: user_worked_hours(user)
      )
    end
  end

  def user_worked_hours(user)
    user.events.inject(0) { |sum, event| sum + event.total_worked_hours }
  end
end

class ReportResult < OpenStruct; end
