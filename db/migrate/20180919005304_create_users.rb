class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :coins
      t.string :invite_code
      t.string :referred_invite_code
      t.string :image
      t.text :coupons_used, array: true, default: []

      t.timestamps
    end
  end
end
