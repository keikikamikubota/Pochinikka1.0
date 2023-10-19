require 'rails_helper'
Rspec.describe '顧客ユーザーモデル機能', type: :model do
  let!(:admin) { Factorybot.create(:admin) }
  describe 'バリデーションテスト' do
    context 'ユーザー新規作成の時' do
      it 'email未記入のバリデーションに引っかかる' do

      end
      it 'emailが被っている時にユニーク制約に引っかかる'do

      end
      it '電話番号が未記入の場合バリデーションに引っかかる' do

      end
      it 'バリデーションエラーメッセージが表示されている' do

      end
    end
  end
end