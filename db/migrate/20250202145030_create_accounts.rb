class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :account_type, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :balance, default: 0

      t.timestamps
    end
  end
end
