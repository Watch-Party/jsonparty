class Comment < ApplicationRecord

  validates_presence_of :content

  belongs_to :post
  belongs_to :user

  after_create_commit { CommentBroadcastWorker.perform_async self.id }
end
