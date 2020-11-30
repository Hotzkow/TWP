Feature: Manage Emails

	Scenario: Search Emails
		When Next
		* enter "mclienttest159@gmail.com" as email
		* enter "sample42P!" as password
		* Next
		# similarity of 0.3703 to other text field 'Give this account a name optional'
		* enter "Tester" into Type your name (displays on outgoing messages)
		* Done
		* OK
		* Unified Inbox
		* Search
		* enter "Google" into Search