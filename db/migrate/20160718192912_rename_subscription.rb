class RenameSubscription < ActiveRecord::Migration[5.0]
  def change
    rename_table :subscriptions, :show_users
  end
end
