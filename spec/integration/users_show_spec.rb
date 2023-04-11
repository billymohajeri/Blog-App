require_relative '../rails_helper'

RSpec.describe 'User testing', type: :feature do
  describe 'index page' do
    before(:example) do
      @user = User.create(name: 'Amen', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Engineer',
                          posts_counter: 1)
      visit users_path
    end

    it 'renders the username of all other users.' do
      User.all.each do |user|
        expect(page).to have_content(user.name)
      end
    end

    it 'renders the profile picture of each user.' do
      User.all.each do |user|
        expect(page).to have_xpath("//img[@src = '#{user.photo}' ]")
      end
    end

    it 'should render correct posts number ' do
      User.all.each do |user|
        expect(page).to have_content(user.posts_counter)
      end
    end

    it "redirected to that user's show page after clicking on user" do
      click_link @user.name
      expect(page).to have_current_path(user_path(@user.id))
    end
    describe 'show page' do
      before(:example) do
        @user = User.create(name: 'Amen', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Engineer',
                            posts_counter: 3)
        @first_post = Post.create(title: 'First', text: 'First post', comments_counter: 1, likes_counter: 1,
                                  author: @user)
        @second_post = Post.create(title: 'Second', text: 'Second post', comments_counter: 1, likes_counter: 1,
                                   author: @user)
        @third_post = Post.create(title: 'Third', text: 'Third post', comments_counter: 1, likes_counter: 1,
                                  author: @user)
        visit user_path(id: @user.id)
      end
      it "should render user's profile picture" do
        expect(page).to have_xpath("//img[@src = '#{@user.photo}' ]")
      end
      it 'should render user name' do
        expect(page).to have_content(@user.name)
      end
      it 'should render number of posts the user has written' do
        expect(page).to have_content(@user.posts_counter)
      end
      it "should render user's bio" do
        expect(page).to have_content(@user.bio)
      end
      it "should render user's first 3 posts" do
        expect(page).to have_content(@first_post.text)
        expect(page).to have_content(@second_post.text)
        expect(page).to have_content(@third_post.text)
      end
      it "should have a button to view all of a user's posts" do
        expect(page).to have_link('See all posts', href: user_posts_path(user_id: @user.id))
      end
      it 'should redirects to all posts show page.' do
        click_link 'See all posts'
        expect(page).to have_current_path(user_posts_path(user_id: @user.id))
      end
    end
  end
end
