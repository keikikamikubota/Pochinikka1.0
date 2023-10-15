# status_array = %w(未対応 要電話 不在 電話拒否 資料送付 商談日程調整)
# status_array.each do |name|
#   Status.create!(name: name)
# end
#
# user = User.create!(
#   name: "第一ユーザー",
#   email: "test@test.com",
#   phone: "090-0000-0000",
#   status: Status.first
# )
#
# admin = Admin.create!(
#   name: "テスト管理者",
#   email: "admin@test.com",
#   password: 'test11',
#   password_confirmation: 'test11'
# )
#
# sheet = Sheet.create!(
#   title: "サンプルシート",
#   code: "1469246740"
# )

require 'faker'

# ステータスの数を取得
status_count = Status.count

# 顧客情報を生成してデータベースに保存する
100.times do
  User.create(
    name: Faker::Games::Pokemon.name,
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.phone_number,
    status_id: Faker::Number.between(from: 1, to: status_count).to_i,
    note: Faker::Games::Pokemon.move
  )
end