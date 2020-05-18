class RemovecolumnTweetUserIdInteger < ActiveRecord::Migration[5.2]
  def change
    remove_column :tweets, :user_id, :integer
  end
end
