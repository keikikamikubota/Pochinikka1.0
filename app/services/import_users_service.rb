class ImportUsersService
  SPREADSHEET_ID = '1u1tFGXUWaO0HC0c7jAokdJWC6kmXbU1Is_yktYtL0Vk'
  RANGE = 'テスト用シート!A4:D7'

  def initialize(sheet)
    @spreadsheets = Google::Spreadsheets.new
    # 作成済みのインポート設定情報を呼び出す
    @sheet = sheet
  end

  # シートのIDと範囲を指定し、そのデータを抽出する。それをもとにインポート実行する
  def call
    values = @spreadsheets.get_values(SPREADSHEET_ID, RANGE).values
    import_users(values)
  end

  # new画面でシートの要素数を引っ張ってくるメソッド
  def sheet_values
    @spreadsheets.get_values(SPREADSHEET_ID, RANGE).values
  end

  private

def import_users(values)
  values.each do |row|
    attr = {}
    # @sheet.import_details は {selected_title: :name, sheet_column_number: 1} のようなハッシュを含むと仮定
    @sheet.import_details.each do |detail|
      next unless detail.selected_title
      # selected_title は enum なので、これがキーとなる。
      attr[detail.selected_title.to_sym] = row[detail.sheet_column_number - 1]
    end
    # attr は {:name=>"a", :email=>"test1@.com", :status_id=>"1", :phone=>"09000-00000"} のようになります。
    User.create!(attr)
   end
  end
end
