require 'faker'

# Create 50 users
50.times do
  User.create!(
    name: Faker::Name.name,
    age: Faker::Number.between(from: 18, to: 65),
    email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.cell_phone
  )
end
