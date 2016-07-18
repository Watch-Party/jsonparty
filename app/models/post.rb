class Post < ApplicationRecord

  validates_presence_of :content,
                        :time_in_episode

  belongs_to :episode
  belongs_to :user

end
