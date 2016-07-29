class Comment < ApplicationRecord

  validates_presence_of :content,
                        :time_in_episode

  belongs_to :post
  belongs_to :user

  after_create_commit { CommentBroadcastWorker.perform_async self.time_in_episode }
end
