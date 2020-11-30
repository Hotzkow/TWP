Feature: Manage Emails

	Scenario: Setup Email
		When enter "mclienttest159@gmail.com" as email
		* enter "sample42P!" as password
		* continue login
		* enter "Tester" as display name
		* continue

	Scenario: Search Emails
		When agree to terms
		And accept privacy policy
		* open inbox
		* type "Google" Into search for keyword
		Then search result should be present