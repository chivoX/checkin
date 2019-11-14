# frozen_string_literal: true

(1..10).to_a.each do |i|
  user = User.create(email: "test#{i}@tested.com", password: '123456789', password_confirmation: '123456789', account: Account.new( name: "John#{i}", last_name: 'doe', gender: 'male'))

  Event.create(checkin: DateTime.now, checkout: DateTime.now + 2.hours, user: user)
  Event.create(checkin: DateTime.now + 2.hours, checkout: DateTime.now + 4.hours, user: user)
  Event.create(checkin: DateTime.now + 6.hours, checkout: DateTime.now + 8.hours, user: user)
end

Admin.create(email: 'admin@tested.com', password: '123456789', password_confirmation: '123456789')
