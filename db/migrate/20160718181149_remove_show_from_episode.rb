class RemoveShowFromEpisode < ActiveRecord::Migration[5.0]
  def change
    remove_reference :episodes, :show, foreign_key: true
  end
end
