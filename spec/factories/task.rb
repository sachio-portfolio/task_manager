FactoryBot.define do
  factory :task do
    task_name { 'Factoryで作ったデフォルトのタイトル1' }
    discription { 'Factoryで作ったデフォルトのコンテント1' }
    expired_at { '2021-06-01 00:00:00' }
    status { 'done' }
  end
  factory :second_task, class: Task do
    task_name { 'Factoryで作ったデフォルトのタスク名' }
    discription { 'Factoryで作ったデフォルトのコンテント2' }
    expired_at { '2021-07-02 00:00:00' }
    status { 'not_started' }
  end
  factory :new_task, class: Task do
    task_name { '新規作成のテストを書く' }
    discription { '新規作成のコンテント' }
    expired_at { '2021-08-03 00:00:00' }
    status { 'in_progress' }
  end
  factory :show_task, class: Task do
    task_name { '詳細画面の表示のテストを書く' }
    discription { '詳細画面の表示のコンテント' }
    expired_at { '2021-09-04 00:00:00' }
    status { 'in_progress' }
  end
  factory :latest_task, class: Task do
    task_name { '最新のタスク' }
    discription { '作成日時の降順で一覧表示' }
    expired_at { '2021-10-05 00:00:00' }
    status { 'not_started' }
  end
  factory :longest_task, class: Task do
    task_name { '一番期限の長いタスク' }
    discription { '終了期限の降順で一覧表示' }
    expired_at { Time.zone.local(2021, 12, 31) }
    #   expired_at { '2021-12-31 23:59:59' }
    status { 'not_started' }
  end
end
