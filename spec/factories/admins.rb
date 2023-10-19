FactoryBot.define do
  factory :admin do
    name { 'スペックさん' }
    email { "spec@example.com" }
    password { 'specsan'}
  end

  factory :admin2, class: Admin do
    name { 'ドリアン海王' }
    email { "dorian@example.com" }
    password { 'dorian'}
  end
end
