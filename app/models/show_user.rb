class ShowsUser < ApplicationRecord

  #not currently in use (meant to be a way users could 'favorite/follow' shows)

  belongs_to :user
  belongs_to :show
end
