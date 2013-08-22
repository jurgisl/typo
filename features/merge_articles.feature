Feature: Merge articles
	As a blog administrator
	I want to be able to merge similar articles

  Background:
    Given the blog is set up
    And there are articles
    | ID   | Title						  | Content				| Author |
    | 101	 | Does it suck 		  | Abc						| admin  |
    | 102  | No it is ok really		| Def						| admin  |

  Scenario: A non-admin cannot merge articles.
    Given I am logged into the admin panel as a "Blog publisher"
    When I am on the "Does it suck" article's edit page
    Then I should not see "Merge Articles"
  	When I go to the home pag
  	Then I should see "Abc"
  	Then I should see "Def"

  Scenario: When articles are merged, the merged article should contain the text of both previous articles.
  	Given I am logged into the admin panel
  	And I am on the "Does it suck" article's edit page
  	When I fill in "merge_with" with "102"
  	And I press "Merge"
  	Then I should see "Articles sucessfully merged"
  	When I go to the home page
  	Then I should see "AbcDef"

  Scenario: When articles are merged, the merged article should have one author
  	Given I have merged article's "Does it suck" and "No it is ok really"
  	And  I am logged into the admin panel
  	When I am on the manage articles page
  	Then I should see "admin"

  Scenario: Comments on each of the two original articles need to all carry over and point to the new, merged article.
  	Given I am logged into the admin panel
  	And article "Does it suck" has a comment "comment_1" by "Karl"
  	And article "No it is ok really" has a comment "comment_2" by "Eddy"
  	And I have merged article's "Does it suck" and "No it is ok really"
  	When I am on the manage articles page
  	Then I should see a link "2"
  	When I follow "2"
  	Then I should see "comment_1"
  	And I should see "comment_2"

  Scenario: Both articles should exist
  	Given I am logged into the admin panel
  	And I am on the "Does it suck" article's edit page
  	When I fill in "merge_with" with "3"
  	And I press "Merge"
  	Then I should see "Article does not exist"

  Scenario: Cannot merge same article
  	Given I am logged into the admin panel
  	And I am on the "Does it suck" article's edit page
  	When I fill in "merge_with" with "101"
  	And I press "Merge"
  	Then I should see "Cannot merge article with itself"