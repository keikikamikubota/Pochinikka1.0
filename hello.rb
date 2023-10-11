require 'google_drive'

p session = GoogleDrive::Session.from_config('config.json')
sheets = session.spreadsheet_by_key('1u1tFGXUWaO0HC0c7jAokdJWC6kmXbU1Is_yktYtL0Vk').worksheet_by_title("テスト用シート")
# スプレッドシートへの書き込み
sheets[1, 19] = "Hello World"
# シートの保存
sheets.save

