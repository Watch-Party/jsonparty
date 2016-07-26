class PostsController < ApplicationController

  def index
    showname = params[:showname].gsub(/\_/," ")
    show = Show.find_by(title: showname)
    episode = show.episodes.find_by(season: params[:season], episode_number: params[:episode])
    @posts = episode.posts.all.order(:created_at).includes(:user)
  end

  def pop
    post = Post.find(params[:id])
    post.upvote_by current_user
    respond_to do |format|
      format.json { render json: { status: "Post Popped"} }
    end
  end
end
