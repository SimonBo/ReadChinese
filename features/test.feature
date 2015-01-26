Feature: Generating for users
User can take a test that's generated based on the texts he's read, words he's favorited and/or checked
  Background:
    Given chinese texts in database
  
  Scenario: Gap-fill test after reading text
    Given a logged in user
    Given the user visits a text show page
    And the user clicks "Gap-fill" link
    Then a gap-fill test is shown based on the text 

  Scenario: Answering gap fill test
    Given a logged in user that selected to take a gap-fill test
    When the user types the correct answer
    And the user click on "Answer" button
    Then "Correct!" message is displayed