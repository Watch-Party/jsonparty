class AddTimeInEpisodeToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :time_in_episode, :integer
  end
end
