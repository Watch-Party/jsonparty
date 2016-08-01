class AddPostsCountToShows < ActiveRecord::Migration[5.0]
  def change
    add_column :shows, :posts_count, :integer, default: 0
  end
end
