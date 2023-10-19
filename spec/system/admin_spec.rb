require 'rails_helper'

RSpec.describe '管理ユーザーモデル機能', type: :model do
  let!(:admin) { FactoryBot.create(:admin) }
  let!(:admin2){ FactoryBot.create(:admin2) }

  before do
    session[:admin_id] = admin.id
  end

  describe 'アクセスのテスト' do
    context '他の管理ユーザーのパスに飛んだ時' do
      it '自分以外の管理ユーザーへのアクセスが制限されている' do
        visit admin_path(admin2)
        expect.to have_content '本人以外のユーザー閲覧はできません'
      end
    end
  end
end