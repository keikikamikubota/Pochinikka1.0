class FetchColumnService
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