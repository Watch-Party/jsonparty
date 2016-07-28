class AddSeasonsToShows < ActiveRecord::Migration[5.0]
  def change
    add_column :shows, :seasons, :integer
  end
end
