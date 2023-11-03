class UsersController < ApplicationController
  # def index; end
  # def show; end

  layout 'standard'
  def index
    @users = User.order(id: :asc)
  end

  def show
    def show
      @user = User.find(params[:id])
    end
  end
end
