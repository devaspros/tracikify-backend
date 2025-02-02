class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.references :account, null: false, foreign_key: true
      t.integer :transaction_type, default: 0
      t.integer :amount, default: 0
      t.string :description

      t.timestamps
    end
  end
end
