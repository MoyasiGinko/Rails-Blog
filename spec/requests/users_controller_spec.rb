require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    it 'assigns @users' do
      # Create some users
      user1 = User.create(name: 'User 1', photo: 'user1.jpg', bio: 'Bio for User 1', posts_counter: 0)
      user2 = User.create(name: 'User 2', photo: 'user2.jpg', bio: 'Bio for User 2', posts_counter: 0)

      get :index

      # Check if @users contains all users
      expect(assigns(:users)).to match_array([user1, user2])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'assigns @user' do
      # Create a user
      user = User.create(name: 'John', photo: 'john.jpg', bio: 'John\'s bio', posts_counter: 0)

      get :show, params: { id: user.id }

      # Check if @user is assigned correctly
      expect(assigns(:user)).to eq(user)
    end

    it 'assigns @posts' do
      # Create a user
      user = User.create(name: 'John', photo: 'john.jpg', bio: 'John\'s bio', posts_counter: 0)

      # Create some posts for the user
      post1 = Post.create!(title: 'Post 1', text: 'Text 1', author: user, comments_counter: 0, likes_counter: 0)
      post2 = Post.create!(title: 'Post 2', text: 'Text 2', author: user, comments_counter: 0, likes_counter: 0)

      get :show, params: { id: user.id }

      # Check if @posts contains the user's posts
      expect(assigns(:posts)).to match_array([post1, post2])
    end

    it 'renders the show template' do
      # Create a user
      user = User.create(name: 'John', photo: 'john.jpg', bio: 'John\'s bio', posts_counter: 0)

      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
    end
  end
end
