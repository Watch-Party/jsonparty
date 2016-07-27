class AddNameToFeeds < ActiveRecord::Migration[5.0]
  def change
    add_column :feeds, :name, :string
  end
end
