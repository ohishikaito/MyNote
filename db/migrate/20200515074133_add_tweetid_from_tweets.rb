class AddTweetidFromTweets < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :user_id, :integer
  end
end
