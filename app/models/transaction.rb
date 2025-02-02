class Transaction < ApplicationRecord
  belongs_to :account

  enum transaction_type: {
    deposit: 0,
    withdrawal: 1,
    transfer: 2
  }

  validates :amount, presence: true, numericality: { greater_than: 0 }
end
