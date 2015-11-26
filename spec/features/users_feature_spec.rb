feature 'User can sign in and out' do
  context "user not signed in and on the homepage" do
    it "should see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it "should not see the 'Sign out' link" do
      visit('/')
      expect(page).not_to have_link('Sign out')
    end

    it "should not be able to add a new restaurant until they sign in" do
      visit('/')
      click_link 'Add a restaurant'
      expect(current_path). to eq '/users/sign_in'
      expect(page).not_to have_content('Name')
    end
  end

  context "user signed in on homepage" do
    before do
      visit '/'
      click_link('Sign up')
      fill_in 'Email', with: 'test@example.com'
      fill_in 'Password', with: 'testtest'
      fill_in 'Password confirmation', with: 'testtest'
      click_button 'Sign up'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Bocado'
      click_button 'Create Restaurant'
    end

    it "should see 'sign out' link" do
      visit  '/'
      expect(page).to have_link 'Sign out'
    end

    it "should not see a 'sign in' and a 'sign up' link" do
      visit '/'
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end

    it "should not allow a user to edit a restaurant he didn't add" do
      click_link('Sign out')
      sign_up('a@b.com','12345678')
      click_link 'Edit Bocado'
      expect(current_path).to eq '/'
      expect(page).not_to have_content 'Name'
      expect(page).to have_content('error')
    end

    it "should not allow a user to delete a restaurant he didn't create" do
      click_link('Sign out')
      sign_up('a@b.com','12341234')
      click_link 'Delete Bocado'
      expect(page).to have_content('Bocado')
    end
    it "cannot review a restaurant more than once" do
      click_link('Sign out')
      sign_up('a@b.com','12341234')
      click_link('Review Bocado')
      fill_in 'Thoughts', with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      expect(page).not_to have_content('Review Bocado')
    end

    it 'cannot delete a review made by another user' do
      click_link('Sign out')
      sign_up('b@c.com','12345678')
      click_link('Review Bocado')
      fill_in 'Thoughts', with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      click_link('Sign out')
      sign_up('a@b.com','12345678')
      expect(page).not_to have_link('Delete your review for Bocado')
    end
  end
end
