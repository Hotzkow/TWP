Feature: Account Registration

	Scenario: Register Your Account
		When Ok, I understand
		* Sign up with Email
		* Sign up with Email
		* type '@email' Into Email
		* enter "sample42P!" Into password
		* next
		* type "Tester" as first name
		* type "Testi" as last name
		* enter "64105" as ZIP
		* Select Country
		* United States
		* Okay
		* next
		* Gender (optional)
		* Male
		* Sign Up
		* Okay
