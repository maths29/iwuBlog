class PostsController < ApplicationController
  # def show
  #   @post = Post.find(params[:id])
  # end

  # def index
  #   @posts = Post.all
  # end

  layout 'standard'
  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: params[:user_id]).order(id: :asc)
    @posts = @posts.paginate(page: params[:page], per_page: 2)
  end

  def show
    @post = Post.find(params[:id])
  end
end
