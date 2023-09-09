require 'swagger_helper'
RSpec.describe 'api/users', type: :request do
  path '/api/users' do
    get 'Retrieves all users' do
      tags 'Users'
      produces 'application/json'
      response '200', 'users found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 photo: { type: :string },
                 bio: { type: :string },
                 posts_counter: { type: :integer }
               },
               required: %w[id name photo bio posts_counter]
        run_test!
      end
    end
  end
  path '/api/users/{id}' do
    get 'Retrieves a user' do
      tags 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      response '200', 'user found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 photo: { type: :string },
                 bio: { type: :string },
                 posts_counter: { type: :integer }
               },
               required: %w[id name photo bio posts_counter]
        let(:id) { User.create(name: 'Test User', photo: 'test.jpg', bio: 'Test Bio', posts_counter: 0).id }
        run_test!
      end
      response '404', 'user not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
  path '/api/users' do
    post 'Creates a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          photo: { type: :string },
          bio: { type: :string },
          posts_counter: { type: :integer }
        },
        required: %w[name photo bio posts_counter]
      }
      response '201', 'user created' do
        let(:user) { { name: 'foo', photo: 'bar', bio: 'baz', posts_counter: 0 } }
        run_test!
      end
      response '422', 'invalid request' do
        let(:user) { { name: 'foo' } }
        run_test!
      end
    end
  end
  path '/api/users/{id}' do
    put 'Updates a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          photo: { type: :string },
          bio: { type: :string },
          posts_counter: { type: :integer }
        },
        required: %w[name photo bio posts_counter]
      }
      response '200', 'user updated' do
        let(:id) { User.create(name: 'Test User', photo: 'test.jpg', bio: 'Test Bio', posts_counter: 0).id }
        let(:user) { { name: 'foo', photo: 'bar', bio: 'baz', posts_counter: 0 } }
        run_test!
      end
      response '404', 'user not found' do
        let(:id) { 'invalid' }
        let(:user) { { name: 'foo', photo: 'bar', bio: 'baz', posts_counter: 0 } }
        run_test!
      end
    end
  end
  path '/api/users/{id}' do
    delete 'Deletes a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      response '200', 'user deleted' do
        let(:id) { User.create(name: 'Test User', photo: 'test.jpg', bio: 'Test Bio', posts_counter: 0).id }
        run_test!
      end
      response '404', 'user not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
