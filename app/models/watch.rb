class Watch < ApplicationRecord

  #user can only watch another user once
  validates_uniqueness_of :watcher, scope: :watched

  #for the watch/user join table
  belongs_to :watcher, foreign_key: 'watcher_id', class_name: 'User'
  belongs_to :watched, foreign_key: 'watched_id', class_name: 'User'
end
