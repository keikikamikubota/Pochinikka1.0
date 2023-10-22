require 'rails_helper'

RSpec.describe '顧客ユーザーシステム機能', type: :system do
  let!(:admin) { FactoryBot.create(:admin) }
  let!(:admin2){ FactoryBot.create(:admin2) }
  let!(:user) { FactoryBot.create(:user) }

  describe '顧客ユーザー新規作成' do
    before do
      login(admin)
      Status.create(id: 1, name: 'テストステータス')
      visit new_user_path
      sleep 1
    end

    context '顧客新規登録画面に飛んだ場合' do
      it 'ユーザーを新規登録できる' do
        fill_in 'user_name', with: 'てすと'
        fill_in 'user_email', with: 'testuser@test.com'
        fill_in 'user_phone', with: '070-1111-2222'
        click_on '保存'
        sleep 1
        expect(page).to have_content '顧客を新規作成しました'
        new_user = User.last
        expect(current_path).to eq user_path(new_user.id)
      end
      it '顧客名がなくても、メールと電話番号があれば登録できる' do
        fill_in 'user_name', with: ''
        fill_in 'user_email', with: 'testuser@test.com'
        fill_in 'user_phone', with: '070-1111-2222'
        click_on '保存'
        sleep 1
        expect(page).to have_content '顧客を新規作成しました'
        new_user = User.last
        expect(current_path).to eq user_path(new_user.id)
      end
      it 'メールアドレスがないと登録できない' do
        fill_in 'user_name', with: 'test'
        fill_in 'user_email', with: ''
        fill_in 'user_phone', with: '070-1111-2222'
        click_on '保存'
        sleep 1
        expect(page).to have_content 'メールアドレスを入力してください'
      end
      it '電話番号がないと登録できない' do
        fill_in 'user_name', with: 'test'
        fill_in 'user_email', with: 'testuser@test.com'
        fill_in 'user_phone', with: ''
        click_on '保存'
        sleep 1
        expect(page).to have_content '電話番号を入力してください'
      end
    end
  end

  describe '顧客ユーザーの編集機能' do
    before do
      login(admin)

      sleep 1
    end

    context '詳細画面に飛んだ時' do
      it '顧客詳細情報が確認できる' do
        visit user_path(user)
        expect(page).to have_content user.name
        expect(page).to have_content user.email
      end
      it '編集画面に遷移される' do
        visit user_path(user)
        click_on '編集する'
        sleep 1
        expect(current_path).to eq edit_user_path(user)
      end
    end
    context '顧客ユーザー情報を編集する時' do
      it 'ユーザー名の変更ができる' do
        visit edit_user_path(user)
        fill_in 'user_name' , with: '名前変更株式会社'
        click_on '保存'
        sleep 1
        expect(page).to have_content '名前変更株式会社'
      end
      it 'メールアドレスが未記入だとエラーが出る' do
        visit edit_user_path(user)
        fill_in 'user_email' , with: ''
        click_on '保存'
        sleep 1
        expect(page).to have_content 'メールアドレスを入力してください'
      end
      it '電話番号が未記入だとエラーが出る' do
        visit edit_user_path(user)
        fill_in 'user_phone' , with: ''
        click_on '保存'
        sleep 1
        expect(page).to have_content '電話番号を入力してください'
      end
      it 'indexを押すと顧客情報は登録されていない' do
        visit edit_user_path(user)
        fill_in 'user_name', with: '登録してほしくない名前'
        click_on 'Index'
        expect(page).not_to have_content '登録してほしくない名前'
      end
    end
  end
end