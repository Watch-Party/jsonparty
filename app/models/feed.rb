class Feed < ApplicationRecord
  belongs_to :episode
  has_many :posts
  has_many :users
end
