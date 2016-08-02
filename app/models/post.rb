class Post < ApplicationRecord

  #used for 'pops'
  acts_as_votable

  validates_presence_of :content,
                        :time_in_episode

  belongs_to :user
  belongs_to :feed
  has_many :comments, dependent: :destroy

  #delegating so can search for episode.posts and show.posts (may update the data structure to be more efficient)
  delegate :episode, :to => :feed, :allow_nil => true
  delegate :show, :to => :episode, :allow_nil => true

  #sends post to broadcast worker after creation
  after_create_commit { PostBroadcastWorker.perform_async self.id }

end
