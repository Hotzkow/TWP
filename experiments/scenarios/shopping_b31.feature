Feature: Account Registration

	Scenario: Name
		When enter "Tester Testi" Into name
		* type "Tester" as first name
		* type "Testi" as last name

	Scenario: Birth Date
		When type "1990" as birth year
		* enter "13" as day
		* enter "January" as month

	Scenario: Add Address
		When text "101 W 11th St, Kansas City, MO" as full address
		* enter "64105" as ZIP
		* enter "101 W 11th St" as street
		* enter "Kansas City" as city
		* enter "Missouri" as State
		* enter "United States" as country

	Scenario: Personal Data
		When do @scenario: Name
		And do @scenario: Birth date
		And do @scenario: Add Address
		* enter "2513753543" as mobile phone number
		* enter "male" as gender
		* enter "30" as age
		* enter "123456789" as driver's license number 

	Scenario: Email Credentials
		When type '@email' Into Email/username
		And enter "sample42P!" Into password

	Scenario: Registration
		When create your account
		* do @scenario: Email Credentials
		* continue
		* do @scenario: Personal Data
		* click submit/signup
		Then @Personal_Data is present in Account Profile
