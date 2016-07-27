class Feed < ApplicationRecord

  validates_presence_of :type,
                        :start_time,
                        :name

  validates_uniqueness_of :name, scope: :episode

  belongs_to :episode
  has_many :posts
  has_many :users, through: :posts
end
