100.times do |n|
  user_name = Faker::Creature::Animal.name
  email = Faker::Internet.email
  password = "password"
  User.create!(user_name: user_name,
               email: email,
               password: password,
               )
end
