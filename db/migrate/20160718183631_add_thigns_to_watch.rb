class AddThignsToWatch < ActiveRecord::Migration[5.0]
  def change
    add_column :watches, :watcher_id, :integer
    add_column :watches, :watched_id, :integer
  end
end
