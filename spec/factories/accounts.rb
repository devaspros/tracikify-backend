FactoryBot.define do
  factory :account do
    user { nil }
    account_type { nil }
    name { "MyString" }
    balance { 1 }
  end
end
