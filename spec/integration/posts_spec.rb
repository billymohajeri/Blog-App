require_relative '../rails_helper'

RSpec.describe 'Post testing', type: :feature do
  describe 'index page' do
    before(:example) do
      @user = User.create(name: 'Amen', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Engineer',
                          posts_counter: 1)
      @post = Post.create(title: 'LM', text: 'My Nth Post', comments_counter: 2, likes_counter: 1, author: @user)
      @first_comment = Comment.create(text: 'First comment', author: @user, post: @post)
      @second_comment = Comment.create(text: 'Second comment', author: @user, post: @post)
      Like.create(author: @user, post: @post)
      visit user_posts_path(user_id: @user.id)
    end
    it "should render user's profile picture" do
      expect(page).to have_xpath("//img[@src = '#{@post.author.photo}' ]")
    end

    it 'should render user name' do
      expect(page).to have_content(@post.author.name)
    end

    it 'should render number of posts the user has written' do
      expect(page).to have_content(@post.author.posts_counter)
    end

    # it 'should render post title' do
    #   expect(page).to have_content(@post.title)
    # end

    it 'should render post text' do
      expect(page).to have_content(@post.text)
    end

    it 'should render the first comment' do
      expect(page).to have_content('First comment')
    end

    it 'should render the number of comments' do
      expect(page).to have_content(@post.comments_counter)
    end

    it 'should render the number of likes' do
      expect(page).to have_content(@post.likes_counter)
    end

    it 'should render the pagenation button' do
      expect(page).to have_content('Pagination')
    end

    it "should redirect to that post's show page" do
      click_link @post.text
      expect(page).to have_current_path(user_post_path(user_id: @user.id, id: @post.id))
    end
  end
end
