require "google/apis/sheets_v4"

class Google::Spreadsheets
  def initialize
    @service = Google::Apis::SheetsV4::SheetsService.new
    @service.authorization = authorize
  end

  # 認証
  def authorize
    # エクスポート用のJSONファイル飲み込み
    config = JSON.parse(File.read('app/services/config.json'))

    # インポート時の秘密鍵
    json_key = JSON.generate(
      private_key: ENV['PRIVATE_KEY'].gsub('\n', "\n"),
      client_email: ENV['CLIENT_EMAIL']
    )

    json_key_io = StringIO.new(json_key)

    authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: json_key_io,
      scope: ["https://www.googleapis.com/auth/spreadsheets"]
    )
    authorizer.fetch_access_token!
    authorizer
  end

  # 指定されたスプレッドシートIDとレンジ（範囲）から値を取得
  def get_values(spreadsheet_id, range)
    @service.get_spreadsheet_values(spreadsheet_id, range)
  end

  # 値を追加するメソッド
  def append_values(spreadsheet_id, range, values, value_input_option: 'RAW')
    value_range = Google::Apis::SheetsV4::ValueRange.new(values: values)
    @service.append_spreadsheet_value(spreadsheet_id, range, value_range, value_input_option: value_input_option)
  end
  
end
