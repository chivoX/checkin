class EventSerializer
  include FastJsonapi::ObjectSerializer

  attributes :checkin, :checkout, :total_worked_hours
end
