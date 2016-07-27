class RenameTypeInFeeds < ActiveRecord::Migration[5.0]
  def change
    rename_column :feeds, :type, :species
  end
end
