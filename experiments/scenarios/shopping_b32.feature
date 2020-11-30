Feature: Login With Valid Credentials

	Scenario: Credentials
		When type '@email' Into Email/username
		And enter "sample42P!" Into password

	Scenario: Login
		When click sign in your account
			* do @scenario: Credentials
			* click submit/signin
			Then @Personal_Data is present in Account Profile
