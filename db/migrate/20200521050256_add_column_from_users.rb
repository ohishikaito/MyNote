class AddColumnFromUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :entry_id, :integer
    add_column :users, :avatar, :string
  end
end
