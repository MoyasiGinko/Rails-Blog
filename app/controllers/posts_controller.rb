class PostsController < ApplicationController
  before_action :find_user, only: %i[index show]
  before_action :find_post, only: [:show]

  def index
    @posts = @user.posts.includes(:comments)
  end

  def show
    @comments = @targated_post.comments
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_post
    @targated_post = @user.posts.find(params[:id])
  end
end
