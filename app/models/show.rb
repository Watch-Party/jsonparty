class Show < ApplicationRecord

  validates_uniqueness_of :title

  validates_presence_of :summary

  has_many :episodes
  has_and_belongs_to_many :users

end
