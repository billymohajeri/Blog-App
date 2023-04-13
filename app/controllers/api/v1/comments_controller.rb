class Api::V1::CommentsController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    post = Post.find(params[:post_id])
    comments = post.comments
    render json: comments
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = User.find(params[:user_id])
    @comment.post = Post.find(params[:post_id])
    if @comment.save
      render json: { status: 'Success', data: @comment }
    else
      render json: { status: 'Failure', error: @comment.errors.full_messages }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
