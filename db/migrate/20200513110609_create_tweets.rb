class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.string :title, null: false
      t.text :text, null: false
      t.string :image
      #削除済み t.references :user, null: false, foreign_key: true 
      t.timestamps
    end
  end
end
