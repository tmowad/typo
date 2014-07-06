Feature: Merge Articles
  As a blog administrator
  In order to avoid multiple similar articles
  I want to be able to merge two articles

  Background:
    Given the blog is set up
    And I am logged into the admin panel
    And user "publisher" owns the following articles
     | id | title    | body             |
     | 3  | Foobar   | brotherly love   |
     | 4  | Lavalamp | LoremIpsum again | 

  Scenario: Successfully merge articles
    Given I am on the article page for "Foobar"
    When I fill in "merge_with" with "4"
    And I press "Merge"
    Then the article "Foobar" should have body "brotherly love LoremIpsum again"

  Scenario: Successfully merging articles consumes the merged in article
    Given I am on the article page for "Foobar"
    When I fill in "merge_with" with "4"
    And I press "Merge"
    Then there should not be any article with id "4"

  Scenario: Prevent self-merging articles
    Given I am on the article page for "Foobar"
    When I fill in "merge_with" with "3"
    And I press "Merge"
    Then the article "Foobar" should have body "brotherly love"
    And I should see "You cannot merge an article with itself"

  Scenario: Gracefully handle a merge request with a non-existant article
    Given I am on the article page for "Foobar"
    When I fill in "merge_with" with "773"
    And I press "Merge"
    Then the article "Foobar" should have body "brotherly love"
    And I should see "Article with id 773 does not exist"

  Scenario: Non-admin user doesn't see the merge button
    Given I am logged in as a publisher
    And I am on the article page for "Foobar"
    Then I should see "Publish settings"
    Then I should not see a "merge_with" text box
    And I should not see a "Merge" button
