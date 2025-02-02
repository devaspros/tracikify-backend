class Account < ApplicationRecord
  belongs_to :user

  has_many :transactions, dependent: :destroy

  enum account_type: {
    efectivo: 0,
    credito: 5,
    ahorros: 10,
    inversiones: 15
  }

  validates :name, presence: true
end

# == Schema Information
#
# Table name: accounts
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  name         :string           not null
#  balance      :integer          default(0)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  account_type :integer          default("ahorros")
#
# Indexes
#
#  index_accounts_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
