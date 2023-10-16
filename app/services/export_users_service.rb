require 'google_drive'

class ExportUsersService
  SPREADSHEET_ID = '1u1tFGXUWaO0HC0c7jAokdJWC6kmXbU1Is_yktYtL0Vk'
  RANGE = 'エクスポート用!A2'

  # -------------------------
  def initialize(spreadsheet_id = SPREADSHEET_ID, range = RANGE)
    @spreadsheet_id = spreadsheet_id
    @range = range
  end

  def session
  @session = GoogleDrive::Session.from_config('config.json')
  end

  def sheet
    @sheet ||= session.spreadsheet_by_key(@spreadsheet_id).worksheet_by_title("エクスポート用")
  end

  def call
    User.all.each_with_index do |user, index|
      # index + 1 because spreadsheet rows start at 1
      sheet[index + 2, 1] = user.name
      sheet[index + 2, 2] = user.email
      sheet[index + 2, 3] = user.phone
      sheet[index + 2, 4] = user.status_id
      sheet[index + 2, 5] = user.note
      sheet[index + 2, 6] = user.admin_note
    end
    sheet.save
  end
end