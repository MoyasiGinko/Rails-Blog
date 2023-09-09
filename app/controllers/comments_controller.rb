class CommentsController < ApplicationController
  def new
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.author = current_user

    if @comment.save
      redirect_to user_post_path(@post.author, @post)
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find_by(author: current_user)

    if @comment
      @comment.destroy
      redirect_to user_post_path(@post.author, @post), notice: 'Deleted!'
    else
      redirect_to user_post_path(@post.author, @post), alert: 'Delete failed.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
