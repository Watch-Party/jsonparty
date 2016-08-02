class Show < ApplicationRecord

  #pg_search for show by title (used in search#shows)
  include PgSearch
  pg_search_scope :search_by_title,
              :against => :title,
              :using => {
                :tsearch => {:prefix => true}
              }

  validates_uniqueness_of :title

  validates_presence_of :summary

  #may update the data structure to be more efficient
  has_many :episodes, dependent: :destroy
  has_and_belongs_to_many :users
  has_many :feeds, through: :episodes
  has_many :posts, through: :feeds

end
