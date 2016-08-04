class AddEndtimeToEpisodes < ActiveRecord::Migration[5.0]
  def change
    add_column :episodes, :end_time, :datetime
  end
end
