require 'rails_helper'

RSpec.describe '顧客ユーザーモデル機能', type: :model do
  before do
    Status.create(id: 1, name: 'テストステータス')
  end

  describe 'バリデーションテスト' do
    context 'ユーザー新規作成の時' do
      it 'email未記入のバリデーションに引っかかる' do
        user = User.new(email: '', phone: 'test')
        expect(user).not_to be_valid
      end
      it 'emailが被っている時にユニーク制約に引っかかる'do
        user1 = User.create(name: 'test', email: 'test', phone: 'test')
        user2 = User.new(name: 'test', email: 'test', phone: 'test')
        expect(user2).not_to be_valid
      end
      it '電話番号が未記入の場合バリデーションに引っかかる' do
        user = User.new(email: 'test', phone: '')
        expect(user).not_to be_valid
      end
      it 'emailと電話番号の記入があれば作成される' do
        user = User.new(email: 'test', phone: 'test')
        expect(user).to be_valid
      end
    end
  end
end