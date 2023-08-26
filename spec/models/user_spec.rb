# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.new(
        name: 'Test User',
        photo: 'user.jpg',
        bio: 'Test bio',
        posts_counter: 0
      )
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user = User.new(
        photo: 'user.jpg',
        bio: 'Test bio',
        posts_counter: 0
      )
      expect(user).not_to be_valid
    end

    it 'is not valid without a photo' do
      user = User.new(
        name: 'Test User',
        bio: 'Test bio',
        posts_counter: 0
      )
      expect(user).not_to be_valid
    end

    it 'is not valid without a bio' do
      user = User.new(
        name: 'Test User',
        photo: 'user.jpg',
        posts_counter: 0
      )
      expect(user).not_to be_valid
    end

    it 'is not valid with a negative posts counter' do
      user = User.new(
        name: 'Test User',
        photo: 'user.jpg',
        bio: 'Test bio',
        posts_counter: -1
      )
      expect(user).not_to be_valid
    end
  end

  describe 'associations' do
    it 'has many posts' do
      user = User.reflect_on_association(:posts)
      expect(user.macro).to eq(:has_many)
    end

    it 'has many likes' do
      user = User.reflect_on_association(:likes)
      expect(user.macro).to eq(:has_many)
    end

    it 'has many comments' do
      user = User.reflect_on_association(:coments)
      expect(user.macro).to eq(:has_many)
    end
  end

  describe '#recent_posts' do
    it 'returns 5 recent posts' do
      user = User.new(
        name: 'User Name',
        photo: 'user.jpg',
        bio: 'User bio goes here',
        posts_counter: 0
      )

      Post.create!(title: 'Post 1', text: 'Text 1', author: user)
      Post.create!(title: 'Post 2', text: 'Text 2', author: user)
      Post.create!(title: 'Post 3', text: 'Text 3', author: user)
      Post.create!(title: 'Post 4', text: 'Text 4', author: user)
      Post.create!(title: 'Post 5', text: 'Text 5', author: user)
      Post.create!(title: 'Post 6', text: 'Text 6', author: user)

      recent_posts = user.recent_posts
      expect(recent_posts.count).to eq(5)
    end
  end
end
