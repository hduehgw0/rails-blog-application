class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
    @pagy, @posts = pagy(@user.posts, items: 10)
  end

  def following
    @pagy, @users = pagy(@user.following, items: 10)
  end

  def followers
    @pagy, @users = pagy(@user.followers, items: 10)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
