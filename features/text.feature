Feature: Adding, editing and reading chinese texts added by users
  Background:
    Given chinese texts in database

  # @javascript
  Scenario: Add text
    Given a logged in user
    Given a user visits the homepage
    And clicks "Read Chinese" link withing the navbar
    Then the user can see a list of texts available for reading
