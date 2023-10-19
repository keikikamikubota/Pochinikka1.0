require 'rails_helper'

RSpec.describe '管理ユーザーモデル機能', type: :system do
  let!(:admin) { FactoryBot.create(:admin) }
  let!(:admin2){ FactoryBot.create(:admin2) }

  describe 'アクセスのテスト' do
    # context '管理ユーザーの登録がある場合' do
    #   it 'ログインが成功している' do
    #     login(admin)
    #     visit root_path
    #     sleep 1
    #     expect(current_path).to eq root_path
    #   end
    # context '管理ユーザーの登録がない場合' do
    #   it 'ログインが失敗している' do
    #     visit root_path
    #     fill_in 'session_email', with: 'test3@test.com'
    #     fill_in 'session_password', with: 'password'
    #     click_on 'Log in'
    #     sleep 1
    #     expect(page).to have_content 'ログインに失敗しました'
    #   end
    # end
    # context '他の管理ユーザーのパスに飛んだ時' do
    #   before do
    #     login(admin)
    #   end
    #   it '自分以外の管理ユーザーへのアクセスが制限されている' do
    #     visit admin_path(admin2)
    #     expect(page).to have_content '本人以外のユーザー閲覧はできません'
    #   end
    # end
  #   context 'サイドバーから自分の名前を押した時' do
  #     before do
  #       login(admin)
  #     end
  #     it '自分の管理ユーザー詳細画面に移動できている' do
  #       click_on 'スペックさん'
  #       sleep 1
  #       expect(current_path).to eq admin_path(admin.id)
  #     end
  #   end
  # end
    #
  discribe '管理ユーザー機能の確認' do
    before do
      login(admin)
      visit admin_path(admin.id)
      sleep 1
    end
    context '編集画面にうつった場合'
  end

end