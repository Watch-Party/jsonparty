class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.text :content
      t.belongs_to :episode, foreign_key: true
      t.belongs_to :user, foreign_key: true
    end
  end
end
