class ImportUsersService
  SPREADSHEET_ID = '1u1tFGXUWaO0HC0c7jAokdJWC6kmXbU1Is_yktYtL0Vk'
  RANGE = 'テスト用シート!A4:D18'

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

  private

  def import_users(values)
    values.each do |row|
      import_user(row)
    end
  end

  def import_user(row)
    user_params = switch_columns(row)
    # binding.pry
    User.create!(user_params)
  end
  
  def switch_columns(row)
      # ここで row[2] と row[3]（C列とD列）のデータをスイッチ
      # 新しいデータの順番に従った配列を作成
      reordered_row = [row[0], row[1], row[3], row[2]]
      # オプション: このデータをHashに変換してキーを利用したい場合
      keys = [:name, :email, :phone, :status_id]
      Hash[keys.zip(reordered_row)]
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