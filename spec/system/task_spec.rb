require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:user){ FactoryBot.create(:user)}
  let!(:admin_user){ FactoryBot.create(:admin_user)}
  let!(:second_user){ FactoryBot.create(:second_user)}

  let!(:longest_task){ FactoryBot.create(:longest_task, user_id: user.id)}
  let!(:task){ FactoryBot.create(:task, user_id: user.id) }
  let!(:second_task){ FactoryBot.create(:second_task, user_id: user.id) }
  let!(:latest_task){ FactoryBot.create(:latest_task, user_id: user.id)}

  before do
    visit new_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    find('.create_session').click_on 'ログイン'
  end
  describe '新規作成機能' do
    let!(:new_task){ FactoryBot.build(:new_task, user_id: user.id) }
    before do
      visit new_task_path
      fill_in 'タスク名', with: new_task.task_name
      fill_in 'タスク詳細', with: new_task.discription
      fill_in '終了期限', with: new_task.expired_at
      click_on '登録する'
    end
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
      expect(page).to have_selector '.alert-success', text: "新たなタスク「#{new_task.task_name}」が作成されました"
      end
    end
  end
  describe '一覧表示機能' do
    before do
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content task.task_name
        expect(page).to have_content second_task.discription
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        expect(first('.task_row')).to have_content latest_task.task_name
      end
    end
    context 'タスクが終了期限の降順に並んでいる場合' do
      before do
        click_on '終了期限'
      end
      it '終了期限が一番遠いものが一番上に表示される' do
        within '.task_list' do
          expect(first('.task_row')). to have_content longest_task.task_name
        end
      end
    end
    context 'タスクが優先順位の昇順に並んでいる場合' do
      let!(:high_priority_task){ FactoryBot.create(:high_priority_task, user_id: user.id)}
      before do
        click_on '優先度'
      end
      it '優先順位が一番高いものが一番上に表示される' do
        within '.task_list' do
          expect(first('.task_row')). to have_content high_priority_task.task_name
        end
      end
    end
  end
  describe '詳細表示機能' do
    let!(:show_task){FactoryBot.create(:show_task, user_id: user.id)}
    before do
      visit tasks_path
      first('tbody tr').click_on '詳細'
    end
    context '任意のタスク詳細画面に遷移した場合' do
     it '該当タスクの内容が表示される' do
       expect(page).to have_content show_task.task_name
     end
    end
  end
  describe '検索機能' do
    before do
      visit tasks_path
    end
    context 'タイトルであいまい検索をした場合' do
      before do
        fill_in 'task_task_name', with: 'Factory'
        click_on '検索'
      end
     it '検索キーワードを含むタスクで絞り込まれる' do
       expect(page).to have_content 'Factory'
     end
    end
    context 'ステータス検索をした場合' do
      before do
        select '未着手', from: 'task[status]'
        click_on '検索'
      end
     it 'ステータスに完全一致するタスクが絞り込まれる' do
       expect(page).to have_content '未着手'
     end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      before do
        fill_in 'task_task_name', with: 'Factory'
        select '完了', from: 'task[status]'
        click_on '検索'
      end
     it '検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる' do
       expect(page).to have_content 'Factory'
       expect(page).to have_content '完了'
     end
    end
  end
end
