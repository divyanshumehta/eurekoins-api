class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :code
      t.integer :amount

      t.timestamps
    end
  end
end
