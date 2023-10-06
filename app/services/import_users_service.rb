class ImportUsersService
  SPREADSHEET_ID = '1u1tFGXUWaO0HC0c7jAokdJWC6kmXbU1Is_yktYtL0Vk'
  RANGE = 'テスト用シート!A4:D18'

  def initialize(sheet)
    @spreadsheets = Google::Spreadsheets.new
    # 作成済みのインポート設定情報を呼び出す
    @sheet = sheet
    @import_details = @sheet.import_details.order(:sheet_column_number)
  end

  # def インポート設定の紐付けを反映させるメソッド
  # スプレッドシートの顧客情報1行が配列で送られてくる。
  #     sheet_column_number(-1)の値をインデックス番号として、配列内の要素に振り分ける。
  #     @import_details内 に保存されているselected_titleの数値として、スプレッドシートの読み込みをする
  # end

  # シートのIDと範囲を指定し、そのデータを抽出する。それをもとにインポート実行する
  def call
    values = @spreadsheets.get_values(SPREADSHEET_ID, RANGE).values
    import_users(values)
  end

  private


  # 上記の抽出されたデータをUserインスタンスに送って、一人ずつ発行していく
  def map_row_to_attributes(row)
    attributes = {}
    @import_details.each do |detail|
      attributes[detail.selected_title.to_sym] = row[detail.sheet_column_number - 1]
    end
    attributes
  end

  def import_users(values)
    values.each do |row|
      user_attributes = map_row_to_attributes(row)
      # ここで得られたuser_attributesをもとにユーザーを作成
      User.create!(user_attributes)
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error "Failed to import user: #{e.message}"
      raise ActiveRecord::Rollback
    end
  end




end

# ---とりあえずインポート自体はうまくいったコード
  # 上記のUser発行時に、インポート設定をsheet_column_number順に並べてハッシュに格納する
  # def map_row_to_attributes(row)
  #   binding.pry
  #   attributes = {}
  #   @import_details.each do |detail|
  #     # detail.sheet_column_numberは1ベースであるため、配列インデックスとして使用するには1減算が必要
  #     attributes[detail.selected_title.to_sym] = row[detail.sheet_column_number - 1]
  #   end
  #   attributes
  #   binding.pry
  # end

  # インポート設定のカラム番号をrowにインデックス番号として並び替える
  # def order_row_data(row)
  #   @import_details.map do |detail|
  #     row[detail.sheet_column_number - 1]
  #   end
  # end
  #
  # def map_attributes_to_ordered_row(ordered_row)
  #   # カラム名をキーとするハッシュを生成
  #   attributes = {}
  #   @import_details.each_with_index do |detail, index|
  #     # ここではselected_titleがカラム名を指していると仮定しています
  #     # カラム名がDBのカラム名と一致している必要があります
  #     attributes[detail.selected_title.to_sym] = ordered_row[index]
  #   end
  #   attributes
  # end