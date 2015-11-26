feature 'Reviewing' do

  before {Restaurant.create(name: 'Abokado')}

  scenario 'allows a uder to leave a review using a form' do
    visit '/'
    sign_up('a@b.com','12341234')
    click_link 'Review Abokado'
    fill_in 'Thoughts', with: 'so so'
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  context 'Deleting a review' do
    before do
    visit '/'
    sign_up('a@b.com','12341234')
    add_restaurant('Bocado')
    click_link 'Review Bocado'
    fill_in 'Thoughts', with: 'so so'
    select '3', from: 'Rating'
    click_button 'Leave Review'
    end

    it 'allows a user to delete a review' do
      click_link('Delete your review for Bocado')
      expect(page).not_to have_content('so so')
    end
  end
end
