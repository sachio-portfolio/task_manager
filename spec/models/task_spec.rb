require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        empty_task_name = Task.new(task_name: '', discription: 'タスク名が空')
        expect(empty_task_name).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        empty_discription = Task.new(task_name: '詳細が空', discription: '')
        expect(empty_discription).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(task_name: 'タスク名', discription: 'タスク詳細')
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能' do
    let!(:task){ FactoryBot.create(:task) }
    let!(:second_task){ FactoryBot.create(:second_task, status: 'done') }
    let!(:latest_task){ FactoryBot.create(:latest_task)}
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it '検索キーワードを含むタスクが絞り込まれる' do
        expect(Task.search_task_name('Factory')).to include(task)
        expect(Task.search_task_name('Factory')).not_to include(latest_task)
        expect(Task.search_task_name('Factory').count).to eq 2
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it 'ステータスに完全一致するタスクが絞り込まれる' do
        expect(Task.search_status('done').count).to eq 2
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it '検索キーワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる' do
        expect(Task.search_task_name('タスク名') && Task.search_status('done')).to include(second_task)
      end
    end
  end
end
