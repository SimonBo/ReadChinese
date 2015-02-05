Given(/^chinese words in database$/) do
  traditional_chars = ['笨蛋', '水', '中國']
  simplified_chars = ['笨蛋', '水', '中国']
  meanings = ['/fool/idiot/', '/water/', '/China/']
  pronunciation = ['ben4 dan4', 'Shui3', 'Zhong1 guo2']

  3.times do |i|
    Word.create(traditional_char: traditional_chars[i], simplified_char: simplified_chars[i], meaning: meanings[i], pronunciation: pronunciation[i], pinyin_count: pronunciation[i].split.count)
  end
end




Given(/^a user searches for "(.*?)"$/) do |arg1|
  fill_in 'word_to_lookup', :with => arg1
  click_button 'lookup_word'
end


Then(/^an "(.*?)" and "(.*?)" is displayed on the site$/) do |arg1, arg2|
  expect(page).to have_content arg1
  expect(page).to have_content arg2
end


Given(/^the user finds a word in dictionary that he hasn't favorited before$/) do
fill_in 'word_to_lookup', :with => '笨蛋'
click_button 'lookup_word'
page.has_content?("Here's what we found:")
page.has_content?("idiot")
@search_result_path = current_path
end

Given(/^the user favorites it$/) do
  click_on 'Favorite'
end

Then(/^that word is added to the user's favorite words$/) do
word = Word.where(simplified_char: '笨蛋')
expect(@user.reload.favorite_words.count).to eq 1
expect(@user.reload.favorite_words).to include word.first.id
end

Given(/^the user finds a word in dictionary that he has favorited before$/) do
  word = Word.where(simplified_char: '笨蛋').first
  @user.favorite_words << word.id
  expect(@user.favorite_words.count).to equal 1

  fill_in 'word_to_lookup', :with => '笨蛋'
  click_button 'lookup_word'
end

Then(/^the user sees that it has been favorited by him$/) do
  page.has_content?("Faved")
end

Then(/^the user is redirected to the same search results page$/) do
  expect(current_path).to eq @search_result_path
end



Then(/^the user can see a list of all the words he has favorited$/) do
  expect(current_path).to eq favorite_words_path
  expect(page).to have_css(".dict_entry")  
end

Given(/^a registered user visits his favorite words page$/) do
  steps %{
    Given a registered user
    Given a user logs in
    And the user visits his favorite words section
  }
end

Given(/^the user favorites a word from the dictionary$/) do
  steps %{
    And the user finds a word in dictionary that he hasn't favorited before
    And the user favorites it
  }
end

Given(/^the user visits his favorite words section$/) do
  visit favorite_words_path
end



Then(/^the word is removed from the list of his favorites$/) do
  expect(page).not_to have_content '笨蛋'
end

When(/^the user clicks on the unfavorite button$/) do
  click_button 'Unfavorite'
end

Then(/^matching words are displayed on the site$/) do
  expect(page).to have_content '笨蛋'
end

