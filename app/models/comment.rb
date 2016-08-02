class Comment < ApplicationRecord

  validates_presence_of :content,
                        :time_in_episode

  belongs_to :post
  belongs_to :user
  belongs_to :feed

  #sends comment to broadcast worker after creation
  after_create_commit { CommentBroadcastWorker.perform_async self.id }
end
