require 'rails_helper'

RSpec.describe 'User posts index page', type: :feature do
  before(:each) do
    @user1 = User.create(name: 'Tom',
                         photo: 'https://cdn.pixabay.com/photo/2015/06/22/08/40/child-817373_1280.jpg',
                         bio: 'Tom bio')
    @user2 = User.create(name: 'Lilly',
                         photo: 'https://cdn.pixabay.com/photo/2015/06/22/08/40/child-817373_1280.jpg',
                         bio: 'Lilly bio')
    @post1 = Post.create(author_id: @user1.id, title: 'Hello', text: 'This is my first post')
    @post2 = Post.create(author_id: @user1.id, title: 'Hi', text: 'This is my second post')
    @comment1 = Comment.create(post_id: @post1.id, author_id: @user2.id, text: 'Hi Tom!')
    @comment2 = Comment.create(post_id: @post1.id, author_id: @user2.id, text: 'Hello Tom!')

    visit user_posts_path(@user1)
  end
  describe 'Display a specific user details and posts' do
    it 'Should display the name of the user' do
      expect(page).to have_content(@user1.name)
    end
    it 'Should display the user photo' do
      expect(page).to have_css(
        "img[src*='https://cdn.pixabay.com/photo/2015/06/22/08/40/child-817373_1280.jpg']", visible: :visible
      )
    end
    it 'Should display user post counter' do
      expect(page).to have_selector('.num-posts', count: 1)
    end
  end
  describe 'Display posts' do
    it 'Should display all posts content' do
      expect(page).to have_content(@post1.text[0, 50])
      expect(page).to have_content(@post2.text[0, 50])
    end

    it 'Should display the all posts' do
      expect(page).to have_content(@post1.text)
      expect(page).to have_content(@post2.text)
    end

    it 'Should display user comment counter and likes counter' do
      expect(page).to have_selector(".right-status", count: 2)
    end
    it 'Should list latest comments' do
      expect(page).to have_content(@comment1.text)
      expect(page).to have_content(@comment2.text)
    end
  end

  describe 'Test links' do
    it 'Should redirect to a specific post when post title is clicked' do
      click_link @post1.title
      expect(page).to have_current_path(user_post_path(@user1, @post1))
    end

    it 'Should redirect to the user when Back to user is clicked' do
      click_link 'Back to users'
      expect(page).to have_current_path(users_path)
    end
  end
end