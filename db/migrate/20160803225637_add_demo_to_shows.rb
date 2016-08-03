class AddDemoToShows < ActiveRecord::Migration[5.0]
  def change
    add_column :shows, :demo, :boolean, :default => false
  end
end
