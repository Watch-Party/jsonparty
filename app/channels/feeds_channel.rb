class FeedsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'posts'
    ActionCable.server.broadcast 'posts',
      content: "Welcome to the room!"
  end
end
