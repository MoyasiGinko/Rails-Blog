class PostsController < ApplicationController
  before_action :find_user, only: %i[index show]
  before_action :find_post, only: [:show]

  def index
    @posts = @user.posts.includes(:comments)
  end

  def show
    @comments = @targated_post.comments
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to user_post_path(current_user, @post) # Redirect to the user's post
    else
      render 'new'
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])

    # Delete associated comments
    @post.comments.destroy_all

    # Now you can safely delete the post
    @post.destroy

    redirect_to user_posts_path(current_user)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_post
    @targated_post = @user.posts.find(params[:id])
  end
end
