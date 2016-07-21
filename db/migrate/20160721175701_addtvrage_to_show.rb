class AddtvrageToShow < ActiveRecord::Migration[5.0]
  def change
    add_column :shows, :tvrage_id, :integer
  end
end
