require 'swagger_helper'

RSpec.describe 'api/comments', type: :request do
  path '/api/users/{user_id}/posts/{post_id}/comments' do
    parameter name: 'user_id', in: :path, type: :string, description: 'user_id'
    parameter name: 'post_id', in: :path, type: :string, description: 'post_id'

    %i[get post].each do |http_method|
      operation "#{http_method} comments" do
        response(200, 'successful') do
          let(:user_id) { '123' }
          let(:post_id) { '123' }

          after do |example|
            example.metadata[:response][:content] = {
              'application/json' => {
                example: JSON.parse(response.body, symbolize_names: true)
              }
            }
          end
          run_test!
        end
      end
    end
  end

  path '/api/users/{user_id}/posts/{post_id}/comments/{id}' do
    parameter name: 'user_id', in: :path, type: :string, description: 'user_id'
    parameter name: 'post_id', in: :path, type: :string, description: 'post_id'
    parameter name: 'id', in: :path, type: :string, description: 'id'

    %i[get delete].each do |http_method|
      operation "#{http_method} comment" do
        response(200, 'successful') do
          let(:user_id) { '123' }
          let(:post_id) { '123' }
          let(:id) { '123' }

          after do |example|
            example.metadata[:response][:content] = {
              'application/json' => {
                example: JSON.parse(response.body, symbolize_names: true)
              }
            }
          end
          run_test!
        end
      end
    end
  end
end
