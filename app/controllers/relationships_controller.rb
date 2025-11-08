class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:following_id])
    current_user.follow(@user)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @relationship = Relationship.find(params[:id])
    @user = @relationship.following
    current_user.unfollow(@user)
    redirect_back(fallback_location: root_path)
  end
end
