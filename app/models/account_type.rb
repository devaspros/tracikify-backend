class AccountType < ApplicationRecord
  has_many :accounts, dependent: :nullify

  validates :name, presence: true
end

# == Schema Information
#
# Table name: account_types
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
