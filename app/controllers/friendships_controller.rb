# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = Friendship.new(friendship_params)
    if @friendship.save
      flash[:success] = 'Friendship successfully sent'
    else
      flash[:danger] = 'Friendship not sent'
    end
    redirect_back(fallback_location: root_path)
  end

  def update
    friendship = find_friendship
    friendship.accepted = true
    if friendship.save
      flash[:success] = 'Friendship accepted'
    else
      flash[:danger] = 'Try again'
    end
    redirect_back(fallback_location: root_path)
  end

  def index
    @friend_requests = current_user.friend_requests
  end

  def destroy
    friendship = find_friendship
    if friendship.delete
      flash[:success] = 'Friendship deleted'
    else
      flash[:danger] = 'Try again'
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id)
  end

  def find_friendship
    user = User.find(params[:id])
    Friendship.where('user_id = ? and friend_id = ?', user, current_user).take
  end
end
