require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.create(name: 'John', photo: 'user.jpg', bio: 'Bio goes here', posts_counter: 0)
      post = Post.new(
        title: 'Title 0',
        text: 'Text 0',
        author: user,
        comments_counter: 0,
        likes_counter: 0
      )
      expect(post).to be_valid
    end

    it 'is not valid without a title' do
      post = Post.new(
        text: 'Text 0'
      )
      expect(post).not_to be_valid
    end

    it 'is not valid without text' do
      post = Post.new(
        title: 'Title 0'
      )
      expect(post).not_to be_valid
    end

    it 'is not valid if text exceeds maximum length' do
      long_text = 'a' * 251
      post = Post.new(
        title: 'Title 0',
        text: long_text
      )
      expect(post).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to an author' do
      association = described_class.reflect_on_association(:author)
      expect(association.macro).to eq :belongs_to
      expect(association.class_name).to eq 'User'
      expect(association.foreign_key).to eq 'author_id'
    end

    it 'has many likes' do
      association = described_class.reflect_on_association(:likes)
      expect(association.macro).to eq :has_many
      expect(association.options[:dependent]).to eq :destroy
    end

    it 'has many comments' do
      association = described_class.reflect_on_association(:comments) # Fix typo: should be :comments
      expect(association.macro).to eq :has_many
      expect(association.options[:dependent]).to eq :destroy
    end
  end

  describe 'callbacks' do
    let(:user) { User.create(name: 'User Name', photo: 'user.jpg', bio: 'User bio goes here', posts_counter: 0) }

    it 'increments posts_counter on author after post creation' do
      expect { Post.create(title: 'Title 0', text: 'Text 0', author: user, comments_counter: 0, likes_counter: 0) }
        .to change { user.reload.posts_counter }.by(1)
    end

    it 'decrements posts_counter on author before post destruction' do
      post = Post.create(title: 'Title 0', text: 'Text 0', author: user, comments_counter: 0, likes_counter: 0)
      expect { post.destroy }
        .to change { user.reload.posts_counter }.by(-1)
    end
  end

  describe 'Show 5 recent comments' do
    it 'will show 5 recent comments' do
      user = User.create(name: 'moyasi', bio: 'I am a knowledge hunger', photo: 'user.jpg', posts_counter: 0)
      post = Post.create!(title: 'Post 1', text: 'Text 1', author: user, comments_counter: 0, likes_counter: 0)
      Comment.create(author: user, post:, text: 'comment 1')
      Comment.create(author: user, post:, text: 'comment 2')
      Comment.create(author: user, post:, text: 'comment 3')
      Comment.create(author: user, post:, text: 'comment 4')
      Comment.create(author: user, post:, text: 'comment 5')

      recent_comments = post.recent_comments
      expect(recent_comments.count).to eq(5)
    end
  end
end
