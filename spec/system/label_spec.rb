require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  let!(:label){ FactoryBot.create(:label) }
  let!(:second_label){ FactoryBot.create(:second_label) }
  let!(:third_label){ FactoryBot.create(:third_label) }

  let!(:user){ FactoryBot.create(:user)}
  let!(:admin_user){ FactoryBot.create(:admin_user)}

  let!(:task){ FactoryBot.create(:task, user_id: user.id) }
  before do
    visit new_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    find('.create_session').click_on 'ログイン'
  end
  describe 'ラベル紐付け' do
    let!(:new_task){ FactoryBot.build(:new_task, user_id: user.id) }
    before do
      visit new_task_path
      fill_in 'タスク名', with: new_task.task_name
      fill_in 'タスク詳細', with: new_task.discription
      fill_in '終了期限', with: new_task.expired_at
      check 'ラベル１'
      check 'ラベル２'
      click_on '登録する'
    end
    context 'タスクを新規作成した場合' do
      it '紐付けしたラベルが表示される' do
        expect(page).to have_content "ラベル１"
        expect(page).to have_content "ラベル２"
      end
    end
    context 'タスクを編集する際にラベルも変更できる' do
      before do
        visit tasks_path
        first('tbody tr').click_on '編集'
        fill_in 'タスク名', with: 'ラベルを編集'
        uncheck 'ラベル１'
        uncheck 'ラベル２'
        check 'ラベル３'
        click_on '登録する'
      end
      it '変更したラベルが表示される' do
        expect(page).to have_selector '.alert-success', text: "タスク「ラベルを編集」の編集が完了しました"
        expect(page).to have_content 'ラベル３'
      end
    end
  end
  describe 'ラベルの作成機能' do
    before do
      visit new_session_path
      fill_in 'メールアドレス', with: admin_user.email
      fill_in 'パスワード', with: admin_user.password
      find('.create_session').click_on 'ログイン'
    end
    context '管理者権限を持つユーザがラベルを作成した場合' do
      before do
        visit admin_users_path
        click_on 'ラベル作成'
        fill_in 'ラベル名', with: '新しいラベル'
        click_on '登録する'
        visit new_task_path
      end
      it 'タスク新崎作成画面で追加したラベルが表示される' do
        expect(page).to have_content '新しいラベル'
      end
    end
  end
end
