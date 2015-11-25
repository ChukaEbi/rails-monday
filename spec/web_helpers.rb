def sign_up(email,pw)
  click_link('Sign up')
  fill_in 'Email', with: email
  fill_in 'Password', with: pw
  fill_in 'Password confirmation', with: pw
  click_button 'Sign up'
end

def add_restaurant(name)
  click_link('Add a restaurant')
   fill_in 'Name', with: name
   click_button 'Create Restaurant'
end
