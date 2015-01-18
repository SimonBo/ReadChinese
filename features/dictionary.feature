Feature: Checking the meaning/pronunciation of chinese words
User can input chinese words and get english meaning + pronunciation
  Background:
    Given chinese words in database

  Scenario Outline: Check meaning of a word
    Given a user visits the homepage
    And a user searches for "<chinese_word>"
    Then an "<definition>" and "<pronunciation>" is displayed on the site

    Examples:
      | chinese_word  | definition  | pronunciation |
      | 笨蛋               | fool  | [ben4", "dan4] |
      | 水  | water  | ["[Shui3]"] |

  Scenario: Favorite a new word
    Given a registered user
    Given a user logs in
    And the user finds a word in dictionary that he hasn't favorited before
    And the user favorites it
    Then that word is added to the user's favorite words
    And the user is redirected to the same search results page

  Scenario: See that word has been favorited
    Given a registered user
    Given a user logs in
    And the user finds a word in dictionary that he has favorited before
    Then the user sees that it has been favorited by him
  
  # @javascript
  Scenario: See list of favorite words
    Given a registered user
    Given a user logs in
    And the user has a few favorited words
    # And the user finds a word in dictionary that he hasn't favorited before
    # And the user favorites it
    And the user visits his favorite words section
    Then the user can see a list of all the words he has favorited

  Scenario: Unfavorite a word
    Given a registered user visits his favorite words page
    When the user clicks on the unfavorite button
    Then the word is removed from the list of his favorites

  Scenario: Look up a word by pinyin
    Given a user visits the homepage
    And a user searches for "ben dan"
    Then matching words are displayed on the site