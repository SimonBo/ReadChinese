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