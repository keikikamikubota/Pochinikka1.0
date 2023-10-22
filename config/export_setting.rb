# config/export_setting.rb
ExportSettings = Struct.new(
  :client_id,
  :client_secret,
  :refresh_token,
  :scope,
  keyword_init: true
)

export_settings = ExportSettings.new(
  client_id:     ENV['CLIENT_ID'],
  client_secret: ENV['CLIENT_SECRET'],
  refresh_token: ENV['REFRESH_TOKEN'],
  scope:         ["https://www.googleapis.com/auth/spreadsheets"]
)

export_settings.freeze
