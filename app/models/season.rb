class Season < ApplicationRecord

  validates_uniqueness_of :season_number, scope: :show

  belongs_to :show
  has_many :episodes

end
