class Feed < ApplicationRecord

  #species used as another word for 'type'
  validates_presence_of :species,
                        :name

  belongs_to :episode
  has_many :posts, dependent: :destroy
  has_many :users, through: :posts
  has_many :comments, dependent: :destroy
end
