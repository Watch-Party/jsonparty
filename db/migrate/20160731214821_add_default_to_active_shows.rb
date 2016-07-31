class AddDefaultToActiveShows < ActiveRecord::Migration[5.0]
  def change
    change_column :shows, :active, :boolean, default: true 
  end
end
