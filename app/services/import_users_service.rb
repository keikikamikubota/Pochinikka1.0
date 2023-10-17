class ImportUsersService
  attr_reader :errors

  # ステータステキストとstatus_idのマッピング
  STATUS_MAPPING = {
    '未対応' => 1,
    '要電話' => 2,
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
  end

  # new画面でシートの要素数を引っ張ってくるメソッド
  def sheet_values
    @spreadsheets.get_values(@spreadsheet_id, @range).values
  end

  # インポート実行メソッド
  def call
    values = @spreadsheets.get_values(@spreadsheet_id, @range).values
    import_users(values)
  end

  private

  def import_users(values)
    values.each do |row|
      attr = {}
      @sheet.import_details.each do |detail|
        next unless detail.selected_title
        attr_value = row[detail.sheet_column_number - 1]
        # detail.selected_titleがstatus_idだった場合、マッピングの値を適用させる
        if detail.selected_title_status_id?
          unless STATUS_MAPPING.key?(attr_value)
            @errors << {row: row, messages: ["Unknown status value: #{attr_value}"]}
            next
          end
          puts "Before conversion: #{attr_value}"
          attr_value = STATUS_MAPPING[attr_value]
          puts "After conversion: #{attr_value}"
        end
        # インポート設定の数値をシンボル、シートのレコードを値として紐づける
        attr[detail.selected_title.to_sym] = attr_value
      end
      # attrに紐づいたインポート設定をもとにuserを作成していく
      user = User.find_by(email: attr[:email])
      # もしユーザーがすでに登録があれば更新、そうでなければ新規登録
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
