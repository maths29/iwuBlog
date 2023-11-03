class UsersController < ApplicationController
  # def index; end
  # def show; end

  def index
    @users = User.all
  end

  def show
    @user = User.includes(posts: %i[comments user]).find(params[:id])
    @posts = @user.recentposts
  end
end
