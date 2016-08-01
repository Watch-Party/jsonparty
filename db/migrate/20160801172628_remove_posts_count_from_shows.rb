class RemovePostsCountFromShows < ActiveRecord::Migration[5.0]
  def change
    remove_column :shows, :posts_count, :integer
  end
end
