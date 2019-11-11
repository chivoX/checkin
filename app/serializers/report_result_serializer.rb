# frozen_string_literal: true

class ReportResultSerializer
  include FastJsonapi::ObjectSerializer

  attributes :email, :total_worked_hours
end
