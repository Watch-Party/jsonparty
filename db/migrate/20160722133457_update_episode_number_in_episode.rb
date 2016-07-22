class UpdateEpisodeNumberInEpisode < ActiveRecord::Migration[5.0]
  def change
    change_column :episodes, :episode_number, :string
  end
end
