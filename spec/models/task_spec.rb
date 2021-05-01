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
end
