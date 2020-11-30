Feature: Account Registration

	Scenario: Register Your Account
		When click Featured
		* Sign in
		* JOIN
		* type "Tester" as first name
		* type "Testi" as last name
		* type '@email' Into Email
		* enter "sample42P!" as password
		* create account