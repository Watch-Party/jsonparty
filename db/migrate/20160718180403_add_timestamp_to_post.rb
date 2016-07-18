class AddTimestampToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :created_at, :timestamp
    add_column :posts, :updated_at, :timestamp
  end
end
