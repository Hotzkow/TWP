Feature: Tip Calculation

	Scenario: Total bill with Tip
		When enter "41.00" as bill
		And enter "4" as tip percentage
		And calculate bill
		Then total bill with tip should be "42.64"