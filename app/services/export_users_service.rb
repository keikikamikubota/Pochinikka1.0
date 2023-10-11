require "google/apis/sheets_v4"
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'

class ExportUsersService
  SPREADSHEET_ID = '1u1tFGXUWaO0HC0c7jAokdJWC6kmXbU1Is_yktYtL0Vk'
  RANGE = 'テスト用シート!A4:D7'

  # -------------------------
  def initialize(spreadsheet_id = SPREADSHEET_ID, range = RANGE)
    @spreadsheet_id = spreadsheet_id
    @range = range
  end

  def call
    # User モデルからエクスポートしたいデータを取得
    users_data = User.all.map do |user|
      [user.id, user.name, user.email, user.phone,
      user.status_id]
    end

  # # config.jsonを読み込んでセッションを確立
  # session = GoogleDrive::Session.from_config("app/services/config.json")

    # Google::Spreadsheets インスタンスを作成
    google_spreadsheets = Google::Spreadsheets.new

    # スプレッドシートにデータを書き込む
    google_spreadsheets.append_values(@spreadsheet_id, @range, users_data)
  end
end