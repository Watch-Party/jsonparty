class RenameInEpisodes < ActiveRecord::Migration[5.0]
  def change
    remove_column :episodes, :show_format
  end
end
