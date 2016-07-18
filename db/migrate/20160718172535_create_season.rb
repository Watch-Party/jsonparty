class CreateSeason < ActiveRecord::Migration[5.0]
  def change
    create_table :seasons do |t|
      t.integer :season_number
      t.belongs_to :show, foreign_key: true
    end
  end
end
