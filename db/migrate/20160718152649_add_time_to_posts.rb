class AddTimeToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :time_in_episode, :integer
  end
end
