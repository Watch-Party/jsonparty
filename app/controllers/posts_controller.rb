class PostsController < ApplicationController

  def show
    @post = Post.find params[:id]
  end

  def index
    showname = params[:showname].gsub(/\_/," ")
    show = Show.find_by(title: showname)
    episode = show.episodes.find_by(season: params[:season], episode_number: params[:episode])
    @posts = episode.posts.all.order(:created_at).includes(:user)
  end

  def create
    feed = Feed.first
    showname = params[:showname].gsub(/\_/," ")
    show = Show.find_by(title: showname)
    episode = show.episodes.find_by(season: params[:season], episode_number: params[:episode])
    @posts = episode.posts.all.order(:created_at).includes(:user)
    post = feed.posts.new(:content params[:content])
    post.time_in_episode = Time.now
    post.user = current_user
    if post.save
      ActionCable.server.broadcast 'posts',
        content:    post.content,
        username:   post.user.screen_name,
        thumb_url:  post.user.avatar.thumb.url,
        timestamp:  (post.created_at.in_time_zone('Eastern Time (US & Canada)')).strftime("%B %-d %Y - %I:%M%p EST")
      head :ok
    else
      respond_to do |format|
        format.json { render json: { status: "Unable to create post"} }
      end
    end
  end

  def update
    @episode = Episode.find params[:id]
  end

  def destroy
    @post = Post.find params[:id]
    @post.destroy
    respond_to do |format|
      format.json { render json: { status: :ok} }
    end
  end

  private

  def post_params
    params.permit(:content, :feed_id)
  end
end
