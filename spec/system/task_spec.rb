require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    let!(:new_task){ FactoryBot.build(:new_task) }
    before do
      visit new_task_path
      fill_in 'Task name', with: new_task.task_name
      fill_in 'Discription', with: new_task.discription
      click_on '登録する'
    end
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
      expect(page).to have_selector '.alert-success', text: new_task.task_name
      end
    end
  end
  describe '一覧表示機能' do
    let!(:task){ FactoryBot.create(:task) }
    let!(:second_task){ FactoryBot.create(:second_task) }
    before do
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content task.task_name
        expect(page).to have_content second_task.discription
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
