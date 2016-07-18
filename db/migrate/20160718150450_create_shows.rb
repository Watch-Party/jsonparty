class CreateShows < ActiveRecord::Migration[5.0]
  def change
    create_table :shows do |t|
      t.string :title
      t.string :cover_img_url
      t.text :summary
    end
  end
end
