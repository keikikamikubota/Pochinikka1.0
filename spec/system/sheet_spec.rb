require 'rails_helper'

RSpec.describe 'シートモデル機能', type: :system do
  let!(:admin) { FactoryBot.create(:admin) }
  let!(:admin2){ FactoryBot.create(:admin2) }

  describe 'シート新規作成' do
    before do
      login(admin)
      visit new_sheet_path
      sleep 1
    end
    context '新規インポート作成をする場合' do
      it 'シートの作成ができる' do
        fill_in 'new-title', with: 'てすと'
        fill_in 'sheet_spreadsheet_id', with: '1234890kkkaaa'
        fill_in 'sheet_range', with: 'Sheet3!A2B4'
        select '1', from: 'sheet_import_details_attributes_0_sheet_column_number'
        select '名前', from: 'sheet_import_details_attributes_0_selected_title'
        click_on '設定を登録'
        expect(page).to have_content 'シートの作成に成功しました'
        expect(page).to have_content 'インポート設定: name'
      end
      it 'タイトルがないと登録できない' do
        fill_in 'sheet_spreadsheet_id', with: '1234890kkkaaa'
        fill_in 'sheet_range', with: 'Sheet3!A2B4'
        select '1', from: 'sheet_import_details_attributes_0_sheet_column_number'
        select '名前', from: 'sheet_import_details_attributes_0_selected_title'
        click_on '設定を登録'
        expect(page).to have_content '入力に不備があります'
      expect(page).to have_content 'タイトルを入力してください'
      end
      it 'スプレッドシートIDがないと登録できない' do
        fill_in 'new-title', with: 'てすと'
        fill_in 'sheet_range', with: 'Sheet3!A2B4'
        select '1', from: 'sheet_import_details_attributes_0_sheet_column_number'
        select '名前', from: 'sheet_import_details_attributes_0_selected_title'
        click_on '設定を登録'
        expect(page).to have_content '入力に不備があります'
        expect(page).to have_content 'スプレッドシートIDを入力してください'
      end
      it 'セル範囲がないと登録できない' do
        fill_in 'new-title', with: 'てすと'
        fill_in 'sheet_spreadsheet_id', with: '1234890kkkaaa'
        select '1', from: 'sheet_import_details_attributes_0_sheet_column_number'
        select '名前', from: 'sheet_import_details_attributes_0_selected_title'
        click_on '設定を登録'
        expect(page).to have_content '入力に不備があります'
        expect(page).to have_content 'セル範囲を入力してください'
      end
      it 'インポート設定がなくても登録ができる' do
        fill_in 'new-title', with: 'てすと'
        fill_in 'sheet_spreadsheet_id', with: '1234890kkkaaa'
        fill_in 'sheet_range', with: 'Sheet3!A2B4'
        click_on '設定を登録'
        expect(page).to have_content 'シートの作成に成功しました'
        new_sheet = Sheet.last
        expect(current_path).to eq sheet_path(new_sheet.id)
      end
      it 'インポート設定がデフォルトだと10件表示されている' do
        visit new_sheet_path
        # idがsheet_column_numberを含むセレクトボックスが10こあるか
        expect(page).to have_css("select[id*='sheet_column_number']", count: 10)
      end
    end
  end
end