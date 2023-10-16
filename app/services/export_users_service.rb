require 'google_drive'

class ExportUsersService
  # SPREADSHEET_ID = '1u1tFGXUWaO0HC0c7jAokdJWC6kmXbU1Is_yktYtL0Vk'
  # RANGE = 'シート8!A2'

  def initialize(spreadsheet_id = SPREADSHEET_ID, range = RANGE)
    @spreadsheet_id = spreadsheet_id
    @range = range
    @sheet_name, @cell_range = parse_range(@range)
  end

  def session
  @session = GoogleDrive::Session.from_config('config.json')
  end

  # ここのシート名の指定がないとエラーになる(google_driveが@sheet必要なため？)
  def sheet
    @sheet ||= session.spreadsheet_by_key(@spreadsheet_id).worksheet_by_title(@sheet_name)
    # binding.pry
  end

  def call
    begin
      User.all.each_with_index do |user, index|
        sheet[index + 2, 1] = user.name
        sheet[index + 2, 2] = user.email
        sheet[index + 2, 3] = user.phone
        sheet[index + 2, 4] = user.status_id
        sheet[index + 2, 5] = user.note
        sheet[index + 2, 6] = user.admin_note
      end
      sheet.save
      true
    rescue => e
        Rails.logger.error "Export failed: #{e.message}"
      false
    end
  end

  private

  def parse_range(range)
    # 例："Sheet1!A1:B2" => ["Sheet1", "A1:B2"]
    range.split('!', 2)
  end
end