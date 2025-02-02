FactoryBot.define do
  factory :account do
    user { nil }
    account_type { "ahorros" }
    name { "MyString" }
    balance { 1 }
  end
end
