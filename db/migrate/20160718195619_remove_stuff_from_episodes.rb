class RemoveStuffFromEpisodes < ActiveRecord::Migration[5.0]
  def change
    remove_reference :episodes, :season, foreign_key: true
  end
end
