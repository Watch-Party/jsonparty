class AddNetworkToShows < ActiveRecord::Migration[5.0]
  def change
    add_column :shows, :network, :string
  end
end
