class AddTvRageIdToEpisodes < ActiveRecord::Migration[5.0]
  def change
    add_column :episodes, :tvrage_e_id, :integer
  end
end
