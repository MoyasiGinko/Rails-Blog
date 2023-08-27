require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create!(name: 'User Name', photo: 'user.jpg', bio: 'User bio goes here', posts_counter: 0) }
  let(:post) { Post.create!(title: 'Title 0', text: 'Text 0', author: user, comments_counter: 0, likes_counter: 0) }

  describe 'increase_likes_counter on associated post creation' do
    before do
      Like.create!(author: user, post:)
      post.reload
    end

    it 'increases the likes_counter of the associated post after creating a like' do
      expect do
        Like.create!(author: user, post:)
        post.reload
      end.to change { post.likes_counter }.by(1)
    end

    it 'does not increase the likes_counter if like is not created' do
      expect do
        # Create other objects or perform actions, but not Like
      end.not_to(change { post.likes_counter })
    end
  end
end
