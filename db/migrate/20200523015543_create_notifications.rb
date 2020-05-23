class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :tweet_id
      t.integer :comment_id
      t.integer :message_id
      t.integer :room_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end

    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
    add_index :notifications, :tweet_id
    add_index :notifications, :comment_id
    add_index :notifications, :message_id
    add_index :notifications, :room_id
  end
end
