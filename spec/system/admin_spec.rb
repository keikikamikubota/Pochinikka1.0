require 'rails_helper'

RSpec.describe '管理ユーザーシステム機能', type: :system do
  let!(:admin) { FactoryBot.create(:admin) }
  let!(:admin2){ FactoryBot.create(:admin2) }

  describe 'アクセスのテスト' do
    context '管理ユーザーの登録がある場合' do
      it 'ログインが成功している' do
        login(admin)
        visit root_path
        sleep 1
        expect(current_path).to eq root_path
      end
    end
    context '管理ユーザーの登録がない場合' do
      it 'ログインが失敗している' do
        visit root_path
        fill_in 'session_email', with: 'test3@test.com'
        fill_in 'session_password', with: 'password'
        click_on 'Log in'
        sleep 1
        expect(page).to have_content 'ログインに失敗しました'
      end
    end
    context '他の管理ユーザーのパスに飛んだ時' do
      before do
        login(admin)
      end
      it '自分以外の管理ユーザーへのアクセスが制限されている' do
        visit admin_path(admin2)
        expect(page).to have_content '本人以外のユーザー閲覧はできません'
      end
    end
    context 'サイドバーから自分の名前を押した時' do
      before do
        login(admin)
      end
      it '自分の管理ユーザー詳細画面に移動できている' do
        click_on 'スペックさん'
        sleep 1
        expect(current_path).to eq admin_path(admin.id)
      end
    end
  end

  describe '管理ユーザー機能の確認' do
    before do
      login(admin)
      visit admin_path(admin.id)
    end
    context '編集画面にうつった場合' do
      it '名前を変更できる' do
        click_on '編集する'
        fill_in 'admin_name', with: 'ドイル'
        fill_in 'admin_email', with: 'spec@example.com'
        fill_in 'admin_password', with: 'specsan'
        fill_in 'admin_password_confirmation', with: 'specsan'
        click_on '更新'
        expect(page).to have_content 'ドイル'
      end
      it 'メールアドレスを変更できる' do
        click_on '編集する'
        fill_in 'admin_email', with: 'doil@example.com'
        fill_in 'admin_password', with: 'specsan'
        fill_in 'admin_password_confirmation', with: 'specsan'
        click_on '更新'
        expect(page).to have_content 'doil@example.com'
      end
      it 'パスワードを変更できる' do
        click_on '編集する'
        fill_in 'admin_password', with: 'aaaaaa'
        fill_in 'admin_password_confirmation', with: 'aaaaaa'
        click_on '更新'
        expect(page).to have_content '更新が完了しました'
      end
      it 'メールアドレスが未記入の場合更新ができない' do
        click_on '編集する'
        fill_in 'admin_email', with: ''
        fill_in 'admin_password', with: 'aaaaaa'
        fill_in 'admin_password_confirmation', with: 'aaaaaa'
        click_on '更新'
        sleep 1
        expect(current_path).not_to eq admin_path(admin.id)
        expect(page).to have_content 'Emailを入力してください'
      end
      it 'パスワードが未記入の場合更新できない' do
        click_on '編集する'
        fill_in 'admin_email', with: 'pec@example.com'
        fill_in 'admin_password', with: ''
        fill_in 'admin_password_confirmation', with: 'aaaaaa'
        click_on '更新'
        expect(current_path).not_to eq admin_path(admin.id)
        expect(page).to have_content 'Passwordは6文字以上で入力してください'
      end
      it 'パスワード確認がパスワード入力と異なる場合登録ができない'do
        click_on '編集する'
        fill_in 'admin_email', with: 'spec@example.com'
        fill_in 'admin_password', with: 'specsan2'
        fill_in 'admin_password_confirmation', with: 'aaaaaa'
        click_on '更新'
        sleep 1
        expect(current_path).not_to eq admin_path(admin.id)
        expect(page).to have_content 'Password confirmationとPasswordの入力が一致しません'
      end
      it 'emailの登録がすでにある時、バリデーションエラーメッセージが表示される' do
        click_on '編集する'
          fill_in 'admin_email', with: 'dorian@example.com'
          fill_in 'admin_password', with: 'specsan2'
          fill_in 'admin_password_confirmation', with: 'specsan2'
          click_on '更新'
        sleep 1
          expect(current_path).not_to eq admin_path(admin.id)
      end
    end
  end
end