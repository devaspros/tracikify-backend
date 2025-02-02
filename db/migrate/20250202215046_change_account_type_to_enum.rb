class ChangeAccountTypeToEnum < ActiveRecord::Migration[7.1]
  def change
    remove_column :accounts, :account_type_id

    add_column :accounts, :account_type, :integer, default: 0
  end
end
