require 'rails_helper'

RSpec.describe 'User index page', type: :feature do
  before(:each) do
    @user1 = User.create(name: 'Tomy',
                         photo: 'https://cdn.pixabay.com/photo/2015/06/22/08/40/child-817373_1280.jpg',
                         bio: 'Tomy bio',
                         posts_counter: 0)
    @user2 = User.create(name: 'Lima',
                         photo: 'https://cdn.pixabay.com/photo/2015/06/22/08/40/child-817373_1280.jpg',
                         bio: 'Lima bio',
                         posts_counter: 0)

    Post.create(title: 'Post 1', text: 'Text 1', author: @user1, comments_counter: 0, likes_counter: 0)
    Post.create(title: 'Post 2', text: 'Text 2', author: @user2, comments_counter: 0, likes_counter: 0)

    visit users_path
  end

  it 'Should display the user page heading' do
    expect(page).to have_content('Microverse Community - All Users')
  end

  describe 'Displaying user information' do
    it 'Should display names of all the users' do
      expect(page).to have_content('Tomy')
      expect(page).to have_content('Lima')
    end
    it 'Should display user photos' do
      expect(page).to have_css(
        "img[src*='https://cdn.pixabay.com/photo/2015/06/22/08/40/child-817373_1280.jpg']",
        visible: :visible
      )
      expect(page).to have_css(
        "img[src*='https://cdn.pixabay.com/photo/2015/06/22/08/40/child-817373_1280.jpg']", visible: :visible
      )
    end
    it 'Should display users post counter' do
      expect(page).to have_selector('.num-posts', count: 4) # Assuming there are two users with post counters
    end
  end

  it 'Should redirect to user profile when user is clicked' do
    click_link 'Tomy'
    expect(page).to have_current_path(user_path(@user1))
  end
end
