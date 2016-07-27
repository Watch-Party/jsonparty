class Show < ApplicationRecord

  include PgSearch
  multisearchable :against => :title

  validates_uniqueness_of :title

  validates_presence_of :summary

  has_many :episodes, dependent: :destroy
  has_and_belongs_to_many :users

end
