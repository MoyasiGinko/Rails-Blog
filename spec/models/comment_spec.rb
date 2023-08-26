require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'moyasi', bio: 'I am a knowledge hunger', photo: 'user.jpg', posts_counter: 0) }
  let(:post) { Post.create(title: 'Post 1', text: 'Text 1', author: user) }

  it 'increases the comments_counter of the associated post after create' do
    comment = Comment.new(author: user, post:, text: 'comment 1')
    comment.save

    post.reload
    expect(post.comments_counter).to eq(1)
  end

  it 'validates presence of author_id' do
    comment = Comment.new(post:, text: 'comment without author')
    expect(comment).not_to be_valid
    expect(comment.errors[:author_id]).to include("can't be blank")
  end

  it 'validates presence of post_id' do
    comment = Comment.new(author: user, text: 'comment without post')
    expect(comment).not_to be_valid
    expect(comment.errors[:post_id]).to include("can't be blank")
  end
end
