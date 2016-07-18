class Show < ApplicationRecord

  validates_uniqueness_of :title

  validates_presence_of :summary

  has_many :seasons
  has_many :episodes, through: :seasons
  has_many :users

end
