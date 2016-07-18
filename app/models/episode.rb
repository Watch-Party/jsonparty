class Episode < ApplicationRecord

  validates_uniqueness_of :title, scope: :show
  validates_uniqueness_of :air_date, scope: :show

  validates_presence_of :title,
                        :air_date,
                        :runtime

  has_many :posts
  belongs_to :show

end
