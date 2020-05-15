class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.string :title, null: false
      t.text :text, null: false
      t.string :image
      t.timestamps
    end
  end
end
