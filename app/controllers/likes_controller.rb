class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(author: current_user)

    if @like.save
      redirect_to user_post_path(@post.author, @post), notice: 'Liked!'
    else
      redirect_to user_post_path(@post.author, @post), alert: 'Like failed.'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = @post.likes.find_by(author: current_user)

    if @like
      @like.destroy
      redirect_to user_post_path(@post.user, @post), notice: 'Unliked!'
    else
      redirect_to user_post_path(@post.user, @post), alert: 'Unlike failed.'
    end
  end
end
