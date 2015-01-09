Feature: Checking the meaning/pronunciation of chinese words
User can input chines word and get english meaning + pronunciation
  Scenario: Check meaning of a word
    Given a user visits the homepage
    And a user searches for a chinese word
    Then an english definition and pronunciation is displayed on the site