Feature: navigate to previous page

	Scenario: Access first website
		When enter "www.google.com" as search URL
		Then website "www.google.com" should be present

	Scenario: Access second website
		When enter "www.bing.com" as search URL
		Then website "www.bing.com" should be present

	Scenario: Navigate Back
		When do @scenario: Access first website
		* do @scenario: Access second website
		* click back button
		Then website "www.google.com" should be present