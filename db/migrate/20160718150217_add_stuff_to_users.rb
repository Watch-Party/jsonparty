class AddStuffToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :avatar_url, :string
    add_column :users, :bio, :text
    add_column :users, :screen_name, :string
    add_column :users, :location, :string
  end
end
