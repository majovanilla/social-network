class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(:id)
    @user = current_user
    @comment = @post.comments.build(comment_params)
  end

  private

  def comment_params
    params.require(:comments).permit(:content, :user_id)
  end
end
