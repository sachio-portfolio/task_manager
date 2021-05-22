require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  let!(:user){ FactoryBot.create(:user)}
  let!(:admin_user){ FactoryBot.create(:admin_user)}
  let!(:second_user){ FactoryBot.create(:second_user)}
  describe 'ユーザー新規作成機能' do
    let!(:new_user){ FactoryBot.build(:new_user) }
    context 'ユーザーを新規作成した場合' do
      before do
        visit new_user_path
        fill_in 'ユーザー名', with: new_user.user_name
        fill_in 'メールアドレス', with: new_user.email
        fill_in 'パスワード', with: new_user.password
        fill_in 'パスワード(確認用)', with: new_user.password
        click_on '登録'
      end
      it '作成したユーザーが表示される' do
        expect(page).to have_selector '.alert-success', text: new_user.user_name
      end
    end
    context 'ログインしていないユーザーはタスク一覧にアクセスできない' do
      before do
        visit root_path
      end
      it 'ログイン画面が表示される' do
        expect(page).to have_content 'ログイン画面'
      end
    end
  end
  describe 'セッション機能のテスト' do
    before do
      visit new_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      find('.create_session').click_on 'ログイン'
    end
    context 'ログインができる' do
      it '自分の詳細画面が表示される' do
        expect(page).to have_content "#{user.user_name}さんのマイページ"
      end
    end
    context '自分の詳細画面に飛べる' do
      before do
        visit user_path(user.id)
      end
      it '自分の詳細画面が表示される' do
        expect(page).to have_content "#{user.user_name}さんのマイページ"
      end
    end
    context '一般ユーザが他人の詳細画面に飛ぶとタスク一覧画面に遷移する' do
      before do
        visit user_path(second_user.id)
      end
      it 'タスク一覧画面が表示される' do
        expect(page).to have_content "タスク一覧"
      end
    end
    context 'ログアウトができる' do
      before do
        click_on 'ログアウト'
      end
      it 'ログイン画面が表示される' do
        expect(page).to have_content "ログイン画面"
      end
    end
  end
  describe '管理画面のテスト' do
    before do
      visit new_session_path
      fill_in 'メールアドレス', with: admin_user.email
      fill_in 'パスワード', with: admin_user.password
      find('.create_session').click_on 'ログイン'
    end
    context '管理ユーザは管理画面にアクセスできる' do
      before do
        click_on 'ユーザー一覧'
      end
      it 'ユーザー管理画面が表示される' do
        expect(page).to have_content "ユーザー管理画面"
      end
    end
    context '一般ユーザは管理画面にアクセスできない' do
      before do
        visit new_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        find('.create_session').click_on 'ログイン'
        visit admin_users_path
      end
      it 'タスク一覧が表示され、アラートが出る' do
        expect(page).to have_selector '.alert-warning', text: '管理者のユーザー以外はアクセスできません'
      end
    end
    context '管理ユーザはユーザの新規登録ができる' do
      let!(:new_user){ FactoryBot.build(:new_user) }
      before do
        visit admin_users_path
        click_on 'ユーザー新規作成'
        fill_in 'ユーザー名', with: new_user.user_name
        fill_in 'メールアドレス', with: new_user.email
        fill_in 'パスワード', with: new_user.password
        fill_in 'パスワード(確認用)', with: new_user.password
        check 'user_admin'
        click_on '登録'
      end
      it 'ユーザーの詳細画面に飛び、アラートが表示される' do
        expect(page).to have_selector '.alert-success', text: "新たなユーザー「#{new_user.user_name}」が登録されました"
        expect(page).to have_content "管理詳細"
      end
    end
    context '管理ユーザはユーザの詳細画面にアクセスできる' do
      before do
        visit admin_users_path
        first('tbody tr').click_on '詳細'
      end
      it 'ユーザの詳細ページが表示される' do
        expect(page).to have_content "#{second_user.user_name}さんのマイページ"
      end
    end
    context '管理ユーザはユーザの編集画面からユーザを編集できる' do
      before do
        visit admin_users_path
        first('tbody tr').click_on '編集'
        fill_in 'ユーザー名', with: '編集されたユーザー名'
        fill_in 'パスワード', with: second_user.password
        fill_in 'パスワード(確認用)', with: second_user.password
        click_on '登録'
      end
      it 'ユーザーの詳細画面に飛び、アラートが表示される' do
        expect(page).to have_content "編集されたユーザー名さんのマイページ"
        expect(page).to have_selector '.alert-info', text: "ユーザー「編集されたユーザー名」の編集が完了しました"
      end
    end
    context '管理ユーザはユーザの削除をできる' do
      before do
        visit admin_users_path
        page.accept_confirm do
          first('tbody tr').click_on '削除'
        end
      end
      it 'ユーザー一覧へ戻り、アラートが表示される' do
        expect(page).to have_selector '.alert-danger', text: "ユーザー「#{second_user.user_name}」を削除しました"
      end
    end
  end
end
