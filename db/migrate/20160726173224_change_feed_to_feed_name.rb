class ChangeFeedToFeedName < ActiveRecord::Migration[5.0]
  def change
    rename_column :posts, :feed, :feed_name
  end
end
