# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
status_array = %w(未対応 要電話 不在 電話拒否 資料送付 商談日程調整)
status_array.each do |name|
  Status.create!(name: name)
end

user = User.create!(
  name: "第一ユーザー",
  email: "test@test.com",
  phone: "090-0000-0000",
  status: Status.first
)

sheet = Sheet.create!(
  title: "サンプルシート",
  code: "1469246740"
)