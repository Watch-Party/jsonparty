class AddConfirmedToShow < ActiveRecord::Migration[5.0]
  def change
    add_column :shows, :confirmed, :boolean
  end
end
