class Account < ApplicationRecord
  belongs_to :user
  belongs_to :account_type

  validates :name, presence: true
end

# == Schema Information
#
# Table name: accounts
#
#  id              :integer          not null, primary key
#  user_id         :integer          not null
#  account_type_id :integer          not null
#  name            :string           not null
#  balance         :integer          default(0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_accounts_on_account_type_id  (account_type_id)
#  index_accounts_on_user_id          (user_id)
#
# Foreign Keys
#
#  account_type_id  (account_type_id => account_types.id)
#  user_id          (user_id => users.id)
#
