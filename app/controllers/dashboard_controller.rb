class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    # フォロー中のユーザーの投稿を表示
    @pagy, @posts = pagy(Post.where(user_id: current_user.following.pluck(:id)), items: 10)
  end
end
