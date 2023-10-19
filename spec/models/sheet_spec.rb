require 'rails_helper'

RSpec.describe 'インポート設定モデル', type: :model do
  describe 'バリデーションテスト' do
    context '新規のインポート設定を作成する時' do
      it 'タイトルが未記入の場合バリデーションエラーが発生している' do
        sheet = Sheet.new(title: '', spreadsheet_id: 'test', range: 'test')
        expect(sheet).not_to be_valid
      end
      it 'シートIDが未記入の場合バリデーションエラーが発生している' do
        sheet = Sheet.new(title: 'test', spreadsheet_id: '', range: 'test')
        expect(sheet).not_to be_valid
      end
      it 'セル範囲が未記入の場合バリデーションエラーが発生している' do
        sheet = Sheet.new(title: 'test', spreadsheet_id: 'test', range: '')
        expect(sheet).not_to be_valid
      end
      it 'タイトル、シートID、セル範囲が記入されている場合はシートが作成される' do
        sheet = Sheet.new(title: 'test', spreadsheet_id: 'test', range: 'test!A2D3')
        expect(sheet).to be_valid
      end
    end
  end
end