Given(/^chinese words in database$/) do
  traditional_chars = ['笨蛋', '水', '中國']
  simplified_chars = ['笨蛋', '水', '中国']
  meanings = ['/fool/idiot/', '/water/', '/China/
']
  pronunciation = ['["[ben4", "dan4]"]', '["[Shui3]"]', '["[Zhong1", "guo2]"]']

  3.times do |i|
    Word.create(traditional_char: traditional_chars[i], simplified_char: simplified_chars[i], meaning: meanings[i], pronunciation: pronunciation[i])
  end
end


Given(/^a user visits the homepage$/) do
  visit root_path
end

Given(/^a user searches for a "(.*?)"$/) do |arg1|
  fill_in 'word_to_lookup', :with => arg1
  click_button 'lookup_word'
  page.has_content?("Here's what we found:")
end

Then(/^an "(.*?)" and "(.*?)" is displayed on the site$/) do |arg1, arg2|
  expect(page).to have_content arg1
  expect(page).to have_content arg2
end

Given(/^a registered user$/) do
  @user = FactoryGirl.create(:user)
end


Given(/^a user logs in$/) do
  visit root_path
  click_on 'Sign in'
  page.has_content?("Email")
  fill_in 'Email', :with => @user.email
  fill_in 'Password', :with => @user.password
  click_button 'Sign in'
end

Given(/^the user finds a word in dictionary$/) do
  fill_in 'word_to_lookup', :with => '笨蛋'
  click_button 'lookup_word'
  page.has_content?("Here's what we found:")
  page.has_content?("idiot")
end

Given(/^the user favorites it$/) do
  expect(page).to have_css(".favorite_word")
end

When(/^that word is not in user's favorites$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^that word is added to the user's favorite words$/) do
  pending # express the regexp above with the code you wish you had
end