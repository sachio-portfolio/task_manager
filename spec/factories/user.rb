FactoryBot.define do
  factory :user, class: User do
    user_name { "ユーザー1" }
    email { "test1@mail.com" }
    password { "password" }
    admin { false }
  end
  factory :second_user, class: User do
    user_name { "ユーザー2" }
    email { "tetest@mail.com" }
    password { "password" }
    admin { false }
  end
  factory :new_user, class: User do
    user_name { "新規作成ユーザー" }
    email { "test3@mail.com" }
    password { "password" }
    admin { false }
  end
  factory :admin_user, class: User do
    user_name { "ユーザー4" }
    email { "test4@mail.com" }
    password { "password" }
    admin { true }
  end
  factory :show_user, class: User do
    user_name { "詳細ユーザー" }
    email { "test5@mail.com" }
    password { "password" }
    admin { false }
  end
end
