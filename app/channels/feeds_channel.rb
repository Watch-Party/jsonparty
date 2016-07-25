class FeedsChannel < ApplicationCable::Channel
  def subscribed
    stop_all_streams
    stream_from 'posts'
  end

  def unsubscribed
    stop_all_streams
  end

  def send
    binding.pry
  end
end
