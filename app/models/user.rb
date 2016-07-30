class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  include PgSearch
  pg_search_scope :search_for_user, :against => [:screen_name, :email]


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable,
  #        :confirmable

  validates_uniqueness_of :screen_name

  mount_uploader :avatar, AvatarUploader

  has_and_belongs_to_many :shows
  has_many :posts
  has_many :feeds, through: :posts
  has_many :comments

  has_many :watchers, through: :watcher_watches, source: :watcher
  has_many :watcher_watches, foreign_key: :watched_id, class_name: 'Watch'

  has_many :watched, through: :watched_watches, source: :watched
  has_many :watched_watches, foreign_key: :watcher_id, class_name: 'Watch'
end
