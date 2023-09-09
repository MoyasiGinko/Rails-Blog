require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    it 'returns a successful response' do
      get '/users'
      expect(response).to have_http_status(302)
    end

    it 'renders the index template' do
      get '/users'
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get '/users'
      expect(response.body).to include('Microverse Community - All Users')
    end
  end

  describe 'GET /users/:id' do
    let(:user) { User.create(name: 'Test User', photo: 'test.jpg', bio: 'Test Bio', posts_counter: 0) }

    it 'returns a successful response' do
      get "/users/#{user.id}"
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      get "/users/#{user.id}"
      expect(response).to render_template(:show)
    end

    it 'includes correct user information in the response body' do
      get "/users/#{user.id}"
      expect(response.body).to include(user.name)
      expect(response.body).to include(user.bio)
    end
  end
end
