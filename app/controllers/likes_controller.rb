class LikesController < ApplicationController

  def new
    @like = Like.new
  end

  def create
    @like = Like.new(like_params)
    @like.user = current_user
    redirect_to root_path if @like.save
  end

  private

  def like_params
    params.require(:like).permit(:post_id)
  end
end
