FactoryBot.define do
  factory :task do
    task_name { 'Factoryで作ったデフォルトのタイトル1' }
    discription { 'Factoryで作ったデフォルトのコンテント1' }
  end
  factory :second_task, class: Task do
    task_name { 'Factoryで作ったデフォルトのタイトル2' }
    discription { 'Factoryで作ったデフォルトのコンテント2' }
  end
  factory :new_task, class: Task do
    task_name { '新規作成のテストを書く' }
    discription { '新規作成のコンテント' }
  end
  factory :show_task, class: Task do
    task_name { '詳細画面の表示のテストを書く' }
    discription { '詳細画面の表示のコンテント' }
  end
  factory :latest_task, class: Task do
    task_name { '最新のタスク' }
    discription { '作成日時の降順で一覧表示' }
  end
end
