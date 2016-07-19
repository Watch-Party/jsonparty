class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  validates_uniqueness_of :screen_name

  has_and_belongs_to_many :shows
  has_many :posts

  has_many :watchers, through: :watcher_watches, source: :watcher
  has_many :watcher_watches, foreign_key: :watched_id, class_name: 'Watch'

  has_many :watched, through: :watched_watches, source: :watched
  has_many :watched_watches, foreign_key: :watcher_id, class_name: 'Watch'
end
