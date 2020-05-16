class RemoveUseridReferences < ActiveRecord::Migration[5.2]
  def change
    remove_reference :tweets, :user
  end
end
