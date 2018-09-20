class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.integer :amount
      t.string :receiver
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
