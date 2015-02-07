Given(/^the user clicks "(.*?)" link$/) do |arg1|
  click_on arg1
end

When(/^the user clicks on "(.*?)" button$/) do |arg1|
  click_button arg1
end

Given(/^a logged in user$/) do
  steps %{
    Given a registered user
    Given a user logs in  
  }
end

Given(/^clicks "(.*?)" link within the navbar$/) do |arg1|
  within('nav'){ click_on arg1}
end

Given(/^a user visits the homepage$/) do
  visit root_path
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

Given(/^user clicks on "(.*?)"$/) do |arg1|
  click_on arg1
end