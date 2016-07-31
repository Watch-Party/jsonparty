class Show < ApplicationRecord

  include PgSearch
  pg_search_scope :search_by_title,
              :against => :title,
              :using => {
                :tsearch => {:prefix => true}
              }

  validates_uniqueness_of :title

  validates_presence_of :summary

  has_many :episodes, dependent: :destroy
  has_and_belongs_to_many :users
  has_many :feeds, through: :episodes
  has_many :posts, through: :feeds

end
