require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'GET #index' do
    it 'assigns @posts' do
      # Create a user
      user = User.create(name: 'John', photo: 'user.jpg', bio: 'Bio goes here', posts_counter: 0)

      # Create posts for the user
      post1 = Post.create!(title: 'Post 1', text: 'Text 1', author: user, comments_counter: 0, likes_counter: 0)
      post2 = Post.create!(title: 'Post 2', text: 'Text 2', author: user, comments_counter: 0, likes_counter: 0)

      get :index, params: { user_id: user.id }

      # Check if @posts contains the posts for the user
      expect(assigns(:posts)).to match_array([post1, post2])
    end

    it 'renders the index template' do
      # Create a user
      user = User.create(name: 'John', photo: 'user.jpg', bio: 'Bio goes here', posts_counter: 0)

      get :index, params: { user_id: user.id }
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'assigns @comments' do
      # Create a user
      user = User.create(name: 'John', photo: 'user.jpg', bio: 'Bio goes here', posts_counter: 0)

      # Create a post for the user
      post = Post.create!(title: 'Post 1', text: 'Text 1', author: user, comments_counter: 0, likes_counter: 0)

      get :show, params: { user_id: user.id, id: post.id }
      expect(assigns(:comments)).to eq(post.comments)
    end

    it 'renders the show template' do
      # Create a user
      user = User.create(name: 'John', photo: 'user.jpg', bio: 'Bio goes here', posts_counter: 0)

      # Create a post for the user
      post = Post.create!(title: 'Post 1', text: 'Text 1', author: user, comments_counter: 0, likes_counter: 0)

      get :show, params: { user_id: user.id, id: post.id }
      expect(response).to render_template(:show)
    end
  end
end
