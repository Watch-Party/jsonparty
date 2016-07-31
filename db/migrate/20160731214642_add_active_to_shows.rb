class AddActiveToShows < ActiveRecord::Migration[5.0]
  def change
    add_column :shows, :active, :boolean
  end
end
