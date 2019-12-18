class FriendshipsController < ApplicationController

  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = Friendship.new(friendship_params)
    if @friendship.save
      flash[:success] = "Friendship successfully sent"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "Friendship not sent"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user, :friend)
  end
end
