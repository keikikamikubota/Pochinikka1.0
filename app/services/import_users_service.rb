class ImportUsersService
  # インポート元のシートのURLとシート名、セル範囲を指定
  SPREADSHEET_ID = '1u1tFGXUWaO0HC0c7jAokdJWC6kmXbU1Is_yktYtL0Vk'
  RANGE = 'テスト用シート!A4:F7'
  # 別タブ　fetchの方も合わせて変更すること
  # RANGE = 'サンプル顧客シート!A4:F7'

  def initialize(sheet, spreadsheet_id = SPREADSHEET_ID, range = RANGE)
    @spreadsheets = Google::Spreadsheets.new
    # 作成済みのインポート設定情報を呼び出す
    @sheet = sheet
    @spreadsheet_id = spreadsheet_id
    @range = range
  end

  # データを抽出する。それをもとにインポート実行する
  def call
    values = @spreadsheets.get_values(@spreadsheet_id, @range).values
    import_users(values)
  end
  # new画面でシートの要素数を引っ張ってくるメソッド
  def sheet_values
    @spreadsheets.get_values(@spreadsheet_id, @range).values
  end
  
  private

  # シートのデータをもとに顧客をデータベースに一人ずつ登録する。その際インポート設定の数値をキーに紐づける
  def import_users(values)
    values.each do |row|
      attr = {}
      # @sheet.import_details は {selected_title: :name, sheet_column_number: 1} のようなハッシュを含むと仮定
      @sheet.import_details.each do |detail|
        next unless detail.selected_title
        # selected_title は enum なので、これがキーとなる。
        attr[detail.selected_title.to_sym] = row[detail.sheet_column_number - 1]
      end
      #attrに紐づいたインポート設定をもとにuserを作成していく
      user = User.find_by(email: attr[:email])
      if  user
        user.update!(attr)
      else
        User.create!(attr)
      end
    end
  end
end
