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
    friendship = Friendship.find(params[:friendship_id])
    friendship.accepted = true
    if friendship.save
      Friendship.create(user:friendship.friend, friend:friendship.user, accepted:true)
      flash[:success] = 'Friendship accepted'
    else
      flash[:danger] = 'Try again'
    end
    redirect_back(fallback_location: root_path)
  end

  def index
    @friend_requests = current_user.friend_requests
    @pending_requests = current_user.pending_friends
  end

  def destroy
    friendship = Friendship.find(params[:friendship_id])
    inverse_friendship = Friendship.where('user_id = ? and friend_id = ?', friend, self).take
    if friendship.delete
      inverse_friendship.delete
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
end
