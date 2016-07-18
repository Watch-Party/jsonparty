class CreateSubscription < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.belongs_to :show, foreign_key: true
      t.integer :subscriber_id, foreign_key: true, class_name: 'User'
    end
  end
end
