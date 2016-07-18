class Episode < ApplicationRecord

  validates_uniqueness_of :title, scope: :season
  validates_uniqueness_of :air_date, scope: :season

  validates_presence_of :title,
                        :air_date,
                        :runtime,
                        :season,
                        :episode_number

  has_many :posts
  belongs_to :show, through: :season
  belongs_to :season

end
