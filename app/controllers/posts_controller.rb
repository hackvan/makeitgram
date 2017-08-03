class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @posts = Post.order(created_at: :desc).limit(10)
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to posts_path, flash: { success: 'The post has been created' }
    else
      render :new
    end
  end

  def show
    begin
      @post = Post.find(params[:id])
      @comment = Comment.new
    rescue => e
      redirect_to posts_path, flash: { alert: "The post has not been found" }
    end
  end

  private
    def post_params
      params.require(:post).permit(:description, :photo)
    end
end
