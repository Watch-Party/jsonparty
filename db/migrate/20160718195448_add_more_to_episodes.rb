class AddMoreToEpisodes < ActiveRecord::Migration[5.0]
  def change
    add_reference :episodes, :show, foreign_key: true
  end
end
