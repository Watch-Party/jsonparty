class CreateEpisodes < ActiveRecord::Migration[5.0]
  def change
    create_table :episodes do |t|
      t.string :title
      t.datetime :air_date
      t.integer :runtime
      t.string :show_format
      t.belongs_to :show, foreign_key: true
    end
  end
end
