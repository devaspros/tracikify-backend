class Account < ApplicationRecord
  belongs_to :user

  enum account_type: {
    ahorros: 0
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
#  account_type :integer          default(0)
#
# Indexes
#
#  index_accounts_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
