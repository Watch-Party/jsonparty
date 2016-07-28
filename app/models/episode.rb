class Episode < ApplicationRecord

  validates_uniqueness_of :tvrage_e_id
  validate :can_only_have_one_episode_number_per_season

  validates_presence_of :title,
                        :air_date,
                        :runtime,
                        :season,
                        :episode_number,
                        :tvrage_e_id

  has_many :feeds, dependent: :destroy
  has_many :posts, through: :feeds
  belongs_to :show

  def can_only_have_one_episode_number_per_season
    if self.show.episodes.find_by(season: self.season, episode_number: self.episode_number).present? &&
        (self.episode_number != "special")
      errors.add(:episode_number, "can't be duplicated in the same season")
    end
  end

end
