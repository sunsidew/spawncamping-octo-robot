class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :top
      t.integer :left
      t.text :story
      t.integer :user_id
      t.integer :board_id

      t.timestamps
    end
  end
end
