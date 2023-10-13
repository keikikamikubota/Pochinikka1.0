class FetchColumnService
  # インポート元のシートのURLとシート名、セル範囲を指定
  SPREADSHEET_ID = '1u1tFGXUWaO0HC0c7jAokdJWC6kmXbU1Is_yktYtL0Vk'
  RANGE = 'テスト用シート!A3:I3'
  # カラム数字行がほしい場合はA2からの指定に変更すること

  def initialize(sheet, spreadsheet_id = SPREADSHEET_ID, range = RANGE)
    @spreadsheets = Google::Spreadsheets.new
    # 作成済みのインポート設定情報を呼び出す
    @sheet = sheet
    @fetch_spreadsheet_id = spreadsheet_id
    @fetch_range = range
  end

  # シートの情報が格納されているのはオブジェクトなので、
  # オブジェクトの必要なデータ（今回はカラム情報）のみを抽出する
  def fetch_values
    fetch_data = @spreadsheets.get_values(@fetch_spreadsheet_id, @fetch_range)
    row_values = fetch_data.instance_variable_get(:@values)
    required_row = row_values.first
  end
end