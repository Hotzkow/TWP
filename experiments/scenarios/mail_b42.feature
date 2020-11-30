Feature: Send Email

	Scenario: Add Google Email
		When enter "mclienttest159@gmail.com" as email
		* enter "sample42P!" as password
		* continue Login
		* enter "Tester" as display name
		* continue

	Scenario: send valid Email
		When agree to terms
		And accept privacy policy
		* write new Email
		* enter "registertest@cartmails.com" to recipient
		* enter "test" as subject
		* enter "test content" as message body content
		* click send
		Then "test" mail should be present in outbox