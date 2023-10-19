FactoryBot.define do
  factory :user do
    name { 'てすと株式会社' }
    email { "testcom@example.com" }
    phone { '070-2122-3313' }
    note { '登録されてくれ' }
  end
end