class Feed < ApplicationRecord

  validates_presence_of :species,
                        :name

  belongs_to :episode
  has_many :posts, dependent: :destroy
  has_many :users, through: :posts
  has_many :comments, dependent: :destroy
end
