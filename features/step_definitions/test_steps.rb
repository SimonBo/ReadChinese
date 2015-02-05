Given(/^the user visits a text show page$/) do
  visit text_path(@text1)
end

Then(/^a gap\-fill test is shown based on the text$/) do
  expect(page).to have_content 'Test'
end

Given(/^a logged in user that selected to take a gap\-fill test$/) do
  steps %{
    Given a logged in user
    Given the user visits a text show page
    And the user clicks "Gap-fill" link
  }
end

When(/^the user types the correct answer$/) do
  correct_answer = @text1.reading_tests.first.data['answer']
end

Then(/^"(.*?)" message is displayed$/) do |arg1|
  page.has_content? arg1
end