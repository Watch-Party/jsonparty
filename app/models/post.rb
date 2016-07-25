class Post < ApplicationRecord

  validates_presence_of :content,
                        :time_in_episode

  belongs_to :user
  belongs_to :feed
  has_many :comments

end
