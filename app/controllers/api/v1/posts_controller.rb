class Api::V1::PostsController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    user = User.find(params[:user_id])
    posts = user.posts
    render json: posts
  end
end
