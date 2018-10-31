class AddOneTimeToCoupons < ActiveRecord::Migration[5.1]
  def change
    add_column :coupons, :one_time, :bool
  end
end
