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
  end
end
