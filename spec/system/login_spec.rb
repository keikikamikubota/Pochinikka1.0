require 'rails_helper'

RSpec.describe '管理ユーザーモデル機能', type: :system do
  let!(:admin) { FactoryBot.create(:admin) }
  let!(:admin2){ FactoryBot.create(:admin2) }

  # admin_specでほぼ確認済み。管理機能が増えた場合項目が増えるので残してある
  describe 'ログイン機能' do
    context '登録がある場合' do
      it 'ログインが成功する' do
        login(admin)
        expect(current_path).to eq users_path
      end
    end
  end
end