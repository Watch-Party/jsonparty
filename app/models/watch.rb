class Watch < ApplicationRecord
  validates_uniqueness_of :watcher, scope: :watched

  belongs_to :watcher, foreign_key: 'watcher_id', class_name: 'User'
  belongs_to :watched, foreign_key: 'watched_id', class_name: 'User'
end
