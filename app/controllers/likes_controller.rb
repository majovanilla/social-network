class LikesController < ApplicationController

  def new
    @like = Like.new
  end

  def create
    @like = Like.new(like_params)
    @like.user = current_user
    redirect_to root_path if @like.save
    if @like && @like.save
      @like.destroy
      redirect_to root_path
    end
  end

  def destroy
    @like.destroy if already_liked?
    redirect_to root_path
  end

  private

  def like_params
    params.require(:like).permit(:post_id)
  end

  def already_liked?
    Like.where(user_id: current_user.id, post_id:
    params[:post_id]).exists?
  end
end
