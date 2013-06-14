class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.integer :user_id
      t.integer :board_id
      t.integer :privilege

      t.timestamps
    end
  end
end
