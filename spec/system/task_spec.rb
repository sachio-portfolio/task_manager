require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    let!(:new_task){ FactoryBot.build(:new_task) }
    before do
      visit new_task_path
      fill_in 'タスク名', with: new_task.task_name
      fill_in 'タスク詳細', with: new_task.discription
      fill_in '終了期限', with: new_task.expired_at
      click_on '登録する'
    end
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
      expect(page).to have_selector '.alert-success', text: new_task.task_name
      end
    end
  end
  describe '一覧表示機能' do
    let!(:longest_task){ FactoryBot.create(:longest_task)}
    let!(:task){ FactoryBot.create(:task) }
    let!(:second_task){ FactoryBot.create(:second_task) }
    let!(:latest_task){ FactoryBot.create(:latest_task)}
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
        click_on '終了期限でソートする'
      end
      it '終了期限が一番遠いものが一番上に表示される' do
        expect(first('.task_row')). to have_content longest_task.task_name
      end
    end
  end
  describe '詳細表示機能' do
    let!(:show_task){FactoryBot.create(:show_task)}
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
end
