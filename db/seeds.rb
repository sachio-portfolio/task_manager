100.times do |n|
  user_name = Faker::Creature::Animal.name
  email = Faker::Internet.email
  password = "password"
  User.create!(user_name: user_name,
               email: email,
               password: password,
               admin: false
               )
end

User.create!(user_name: "admin_user",
             email: "admin@mail.com",
             password: "password",
             admin: true
             )

10.times do |n|
  label_name = "ラベル#{n}"
  Label.create!(label_name: label_name)
end

10.times do |n|
  expired_at = Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default)
  status = rand(2)
  priority = rand(2)
  user_id = rand(1..100)
  Task.create!(task_name: "タスク#{n}個目",
               discription: "タスク#{n}個目についての詳細",
               expired_at: expired_at,
               status: status,
               priority: priority,
               user_id: user_id
              )
end

task_labels_list = []
Task.all.ids.each do |task_id|
  task_labels_list << { task_id: task_id, label_id: rand(1..10) }
end
TaskLabel.create!(task_labels_list)
