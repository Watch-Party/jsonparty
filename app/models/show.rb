class Show < ApplicationRecord

  validates_uniqueness_of :title

  validates_presence_of :summary

  has_many :episodes
  has_many :users

end
