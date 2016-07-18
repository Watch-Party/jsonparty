class RenameSubsciber < ActiveRecord::Migration[5.0]
  def change
    rename_column :show_users, :subscriber_id, :user_id
  end
end
