class RemoveDemoFromShows < ActiveRecord::Migration[5.0]
  def change
    remove_column :shows, :demo, :boolean
  end
end
