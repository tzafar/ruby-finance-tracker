class FriendshipsController < ApplicationController
  def create
    Friendship.create(user_id: current_user.id, friend_id: params[:friend])
    redirect_to friends_path
  end

  def destroy
    Friendship.where(user_id: current_user.id, friend_id: params[:id]).first.destroy
    redirect_to friends_path
  end
end