FactoryBot.define do
  factory :task do
    task_name { 'Factoryで作ったデフォルトのタイトル1' }
    discription { 'Factoryで作ったデフォルトのコンテント1' }
    expired_at { '2021-06-01 00:00:00' }
    status { 'done' }
    priority { 'low' }
    association :user
  end
  factory :second_task, class: Task do
    task_name { 'Factoryで作ったデフォルトのタスク名' }
    discription { 'Factoryで作ったデフォルトのコンテント2' }
    expired_at { '2021-07-02 00:00:00' }
    status { 'not_started' }
    priority { 'normal' }
    association :user
  end
  factory :new_task, class: Task do
    task_name { '新規作成のテストを書く' }
    discription { '新規作成のコンテント' }
    expired_at { '2021-08-03 00:00:00' }
    status { 'in_progress' }
    priority { 'low' }
    association :user
  end
  factory :show_task, class: Task do
    task_name { '詳細画面の表示のテストを書く' }
    discription { '詳細画面の表示のコンテント' }
    expired_at { '2021-09-04 00:00:00' }
    status { 'in_progress' }
    priority { 'low' }
    association :user
  end
  factory :latest_task, class: Task do
    task_name { '最新のタスク' }
    discription { '作成日時の降順で一覧表示' }
    expired_at { '2021-10-05 00:00:00' }
    status { 'not_started' }
    priority { 'normal' }
    association :user
  end
  factory :longest_task, class: Task do
    task_name { '一番期限の長いタスク' }
    discription { '終了期限の降順で一覧表示' }
    expired_at { Time.zone.local(2021, 12, 31) }
    status { 'not_started' }
    priority { 'low' }
    association :user
  end
  factory :high_priority_task, class: Task do
    task_name { '優先順位の高いタスク' }
    discription { '優先順位の照準で一番上に表示' }
    expired_at { '2021-05-20 00:00:00' }
    status { 'in_progress' }
    priority { 'high' }
    association :user
  end
end
