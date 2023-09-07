require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  before(:each) do
    @user1 = User.create(name: 'Tom',
                         photo: 'https://cdn.pixabay.com/photo/2015/06/22/08/40/child-817373_1280.jpg', bio: 'Tom bio')
    @post1 = Post.create(author_id: @user1.id, title: 'Hello', text: 'This is my first post')
    @post2 = Post.create(author_id: @user1.id, title: 'Hi', text: 'This is my second post')

    visit user_path(@user1)
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
      expect(page).to have_selector('.num-posts', count: 1
    )
    end
    it 'Should display the bio of the user' do
      expect(page).to have_content(@user1.bio)
    end
    it 'Should display the first 2 posts' do
      expect(page).to have_content(@post1.text)
      expect(page).to have_content(@post2.text)
    end
  end
  describe 'Test links' do
    it 'Should redirect to a specific post when post title is clicked' do
      click_link @post1.title
      expect(page).to have_current_path(user_post_path(@user1, @post1))
    end
    it 'Should redirect to user posts when See all posts is clicked' do
      click_link 'See all posts'
      expect(page).to have_current_path(user_posts_path(@user1))
    end
    it 'Should redirect to users when Back to users is clicked' do
      click_link 'Back to users'
      expect(page).to have_current_path(users_path)
    end
  end
end