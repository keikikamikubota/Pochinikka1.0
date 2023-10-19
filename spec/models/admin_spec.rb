require 'rails_helper'

RSpec.describe '管理ユーザーモデル機能', type: :model do
  describe 'バリデーションテスト' do
    context '新規管理ユーザー作成時' do
      it '名前が空欄だとバリデーションエラーが出る' do
        admin = Admin.new(name: '', email: "test", password: "test")
        expect(admin).not_to be_valid
      end
      it 'メールアドレスが空欄だとバリデーションエラーが出る' do
        admin = Admin.new(name: 'test', email: "", password: "test")
        expect(admin).not_to be_valid
      end
      it 'パスワードが空欄だとバリデーションエラーが出る' do
        admin = Admin.new(name: 'test', email: "test", password: "")
        expect(admin).not_to be_valid
      end
      it 'メールが正しいフォーマットでない場合は作成されない' do
        admin = Admin.new(name: 'test', email: "test", password: "testpass")
        expect(admin).not_to be_valid
      end
      it '名前、メール、パスワードの記入があれば作成される' do
        admin = Admin.new(name: 'test', email: "test@test.com", password: "testpass")
        expect(admin).to be_valid
      end
    end
  end
end