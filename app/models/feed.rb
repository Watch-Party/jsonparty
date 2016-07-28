class Feed < ApplicationRecord

  validates_presence_of :species,
                        :start_time,
                        :name

  belongs_to :episode
  has_many :posts
  has_many :users, through: :posts
end
