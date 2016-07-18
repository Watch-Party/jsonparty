class Renamejoin < ActiveRecord::Migration[5.0]
  def change
    rename_table :show_users, :shows_users
  end
end
