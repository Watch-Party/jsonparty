class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  #pg_search for user by screen_name and/or email (used in search#users)
  include PgSearch
  pg_search_scope :search_by_sn_and_email, :against => [:screen_name, :email],
                  :using => {
                    :tsearch => {:prefix => true}
                  }


  validate :screen_name_does_not_include_disallowed_words
  validates_uniqueness_of :screen_name

  #for carrierwave
  mount_uploader :avatar, AvatarUploader

  #may update the data structure to be more efficient
  has_and_belongs_to_many :shows
  has_many :posts
  has_many :feeds, through: :posts
  has_many :comments

  #for the watch/user join table
  has_many :watchers, through: :watcher_watches, source: :watcher
  has_many :watcher_watches, foreign_key: :watched_id, class_name: 'Watch'

  has_many :watched, through: :watched_watches, source: :watched
  has_many :watched_watches, foreign_key: :watcher_id, class_name: 'Watch'

  #user watches themselves (for filtering on front end purposes) after creation
  after_create_commit { Watch.create(watcher: self,
                                      watched: self) }

  #user autowatches offical watch party user
  after_create_commit { Watch.create(watcher: self,
                                      watched_id: 6) }

  #does not allow screen names to include certain words (will expand)
  def screen_name_does_not_include_disallowed_words
    disallowed = ["watch party"]
    disallowed.each do |d|
      if self.screen_name.include?(d)
        errors.add(:screen_name, "contains disallowed words")
      end
    end
  end

end
