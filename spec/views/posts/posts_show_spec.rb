require 'rails_helper'

RSpec.describe 'User post show page', type: :feature do
  before(:each) do
    @user1 = User.create(name: 'Tomy', photo: 'https://cdn.pixabay.com/photo/2015/06/22/08/40/child-817373_1280.jpg',
                         bio: 'Tom bio')
    @user2 = User.create(name: 'Lima',
                         photo: 'https://cdn.pixabay.com/photo/2015/06/22/08/40/child-817373_1280.jpg',
                         bio: 'Lilly bio')
    @post1 = Post.create(author_id: @user1.id, title: 'Hello', text: 'This is my first post')
    @comment1 = Comment.create(post_id: @post1.id, author_id: @user2.id, text: 'Hi Tom!')
    @comment2 = Comment.create(post_id: @post1.id, author_id: @user2.id, text: 'Hello Tom!')

    visit user_post_path(@user1, @post1)
  end

  describe 'Display a specific post' do
    it 'Should display the title of the post' do
      expect(page).to have_content(@post1.title)
    end

    it 'Should display the post author' do
      expect(page).to have_content(@post1.author.name)
    end

    it 'Should display how many likes the post has' do
      # Create some likes for the post
      Like.create(author: @user2, post: @post1)
      Like.create(author: @user1, post: @post1)

      visit user_post_path(user_id: @user1, id: @post1)

      # Check if the page displays the number of likes
      expect(page).to have_content('Likes: 2') # Update with the expected like count
    end

    it 'Should display how many comments the post has' do
      visit user_post_path(user_id: @user1, id: @post1)

      # Check if the page displays the number of comments
      expect(page).to have_content('Comments: 2') # Update with the expected comment count
    end

    it 'Should display user comment counter and likes counter' do
      expect(page).to have_selector('.right-corner', count: 1)
    end
    it 'Should display all posts content' do
      expect(page).to have_content(@post1.text)
    end
    it 'Should have comments' do
      expect(page).to have_content(@comment1.text)
      expect(page).to have_content(@comment2.text)
    end
    it 'Should have comments authors' do
      expect(page).to have_content(@comment1.author.name)
      expect(page).to have_content(@comment1.text)
      expect(page).to have_content('Lima')
      expect(page).to have_content('Hi Tom!')
    end
  end

  describe 'Test links' do
    it 'Should redirect to the user posts when back to posts is clicked' do
      click_link 'back to posts'
      expect(page).to have_current_path(user_posts_path(@user1))
    end
  end
end
