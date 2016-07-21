class AddDefaultToShow < ActiveRecord::Migration[5.0]
  def change
    change_column :shows, :confirmed, :boolean, :default => false
  end
end
