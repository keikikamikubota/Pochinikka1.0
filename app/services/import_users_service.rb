class ImportUsersService
  attr_reader :errors

  # ステータステキストとstatus_idのマッピング
  STATUS_MAPPING = {
    '未対応' => 1,
    '要荷電' => 2,
    '不在' => 3,
    '電話拒否' => 4,
    '資料送付' => 5,
    '商談日程調整' => 6
  }.freeze

  def initialize(sheet, spreadsheet_id = SPREADSHEET_ID, range = RANGE)
    @spreadsheets = Google::Spreadsheets.new
    # 作成済みのインポート設定情報を呼び出す
    @sheet = sheet
    @spreadsheet_id = spreadsheet_id
    @range = range
    @errors = []
    binding.pry
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
      @sheet.import_details.each do |detail|
        next unless detail.selected_title
        attr_value = row[detail.sheet_column_number - 1]

        # ステータスのテキストをstatus_idに変換
        if detail.selected_title == "status" && STATUS_MAPPING.key?(attr_value)
          puts "Before conversion: #{attr_value}" # 変換前の値を出力
          attr_value = STATUS_MAPPING[attr_value]
          puts "After conversion: #{attr_value}"  # 変換後の値を出力
        end

        attr[detail.selected_title.to_sym] = attr_value
      end
      #attrに紐づいたインポート設定をもとにuserを作成していく
      user = User.find_by(email: attr[:email])
      if  user
        unless user.update(attr)
        @errors << {row: row, messages: user.errors.full_messages}
        end
      else
        unless User.create(attr)
          @errors << {row: row, messages: new_user.errors.full_messages}
        end
      end
    end
  end
end
