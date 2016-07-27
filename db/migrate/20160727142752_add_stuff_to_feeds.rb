class AddStuffToFeeds < ActiveRecord::Migration[5.0]
  def change
    add_column :feeds, :type, :string
    add_column :feeds, :start_time, :datetime
  end
end
