class FeedsController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :set_format

end
