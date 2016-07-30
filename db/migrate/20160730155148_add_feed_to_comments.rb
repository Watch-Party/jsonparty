class AddFeedToComments < ActiveRecord::Migration[5.0]
  def change
    add_reference :comments, :feed, foreign_key: true
  end
end
