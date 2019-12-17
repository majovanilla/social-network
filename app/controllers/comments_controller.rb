class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(:id)
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    redirect_to :back if @comment.save
  end

  def show
    @comments = @post.comments
  end

  private

  def comment_params
    params.require(:comments).permit(:content)
  end
end
