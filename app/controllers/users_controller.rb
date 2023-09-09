class UsersController < ApplicationController
  before_action :find_user, only: [:show]

  def index
    @users = User.all
  end

  def show
    @posts = @user.posts
  end

  def create
    @user = User.new(sign_up_params)

    if @user.save
      # Attach the uploaded photo to the user
      @user.photo.attach(params[:user][:photo]) if params[:user][:photo].present?

      sign_in(@user)
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
