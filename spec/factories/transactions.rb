FactoryBot.define do
  factory :transaction do
    association :account
    transaction_type { "deposit" }
    amount { 500 }
    description { "Hola" }
  end
end
