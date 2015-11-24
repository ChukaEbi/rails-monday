feature 'Reviewing' do

  before {Restaurant.create(name: 'Abokado')}

  scenario 'allows a uder to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review Abokado'
    fill_in 'Thoughts', with: 'so so'
    select '3', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end
end