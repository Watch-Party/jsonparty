class FeedsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'posts'
  end
end
