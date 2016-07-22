class RemoveIndexPostsOnEpisodeId < ActiveRecord::Migration[5.0]
  def change
    remove_index :posts, :episode_id
    remove_column :posts, :episode_id

    add_column :posts, :feed_id, :integer
    add_index :posts, :feed_id
  end
end
