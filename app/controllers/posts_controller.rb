class PostsController < ApplicationController

  def show
    @post = Post.find params[:id]
  end

  def index
    @episode = Episode.find params[:id]
    @posts = @episode.posts.all
  end

  def create
    @episode = Episode.find params[:id]
    @posts = @episode.posts.new
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
