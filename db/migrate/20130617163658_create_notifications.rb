class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :post_id
      t.integer :flag

      t.timestamps
    end
  end
end
