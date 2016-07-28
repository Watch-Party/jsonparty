class AddTimestampToShows < ActiveRecord::Migration[5.0]
  def change
    add_column :shows, :created_at, :datetime
    add_column :shows, :updated_at, :datetime
  end
end
