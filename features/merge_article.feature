Feature: Merge Articles
  As a blog administrator
  In order to avoid multiple similar articles
  I want to be able to merge two articles

  Background:
    Given the blog is set up
    And I am logged into the admin panel
    And the following articles exist
     | id | title    | body             |
     | 2  | Foobar   | LoremIpsum       |
     | 3  | Foobar 2 | LoremIpsum again | 

  Scenario: Successfully merge articles
    Given I am on the article page for "Foobar"
    When I fill in "merge_with" with "3"
    And I press "Merge"
    Then the article "Foobar" should have body "LoremIpsum LoremIpsum again"
    And show me the page
