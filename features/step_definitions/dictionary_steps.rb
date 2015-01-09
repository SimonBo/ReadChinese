Given(/^a user visits the homepage$/) do
  visit root_path
end

Given(/^a user searches for a chinese word$/) do
  word = '笨蛋'
  fill_in 'word_to_lookup', :with => word
  click_button 'lookup_word'
end

Then(/^an english definition and pronunciation is displayed on the site$/) do
  expect(page).to have_content "Here's what we found:"
end