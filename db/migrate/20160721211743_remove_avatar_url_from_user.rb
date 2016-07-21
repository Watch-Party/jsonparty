class RemoveAvatarUrlFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :avatar_url
  end
end
