class PostsController < ApplicationController

  def show
    @post = Post.find params[:id]
  end

  def index
    show = Show.find_by(title: params[:showname])
    episode = show.episodes.find_by(season: params[:season], episode_number: params[:episode])
    @posts = episode.posts.all.order(:created_at).includes(:user)
  end

  def create
    show = Show.find_by(title: params[:showname])
    episode = show.episodes.find_by(season: params[:season], episode_number: params[:episode])
    post = episode.posts.new(user: current_user, content: params[:content], time_in_episode: Time.now)
    if post.save
      respond_to do |format|
        format.json { render json: { status: :ok} }
      end
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
end
