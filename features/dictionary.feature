Feature: Checking the meaning/pronunciation of chinese words
User can input chines word and get english meaning + pronunciation
  Background:
    Given chinese words in database

  Scenario Outline: Check meaning of a word
    Given a user visits the homepage
    And a user searches for a "<chinese_word>"
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

  Scenario: See list of favorite words
    Given a registered user
    Given a user logs in
    And the user has a few favorited words
    And the user clicks on "My favorite words" link
    Then the user can see a list of all the words he has favorited