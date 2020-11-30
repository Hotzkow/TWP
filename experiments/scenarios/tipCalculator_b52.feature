Feature: Tip Calculation

	Scenario: Total bill with Tip
		When enter "41.00" as bill
		And enter "4" as tip percentage
		And calculate bill
		Then total bill with tip should be "42.64"

	Scenario: Split bill
		Given @Total bill with Tip
		When enter "2" into split among number of people
		And calculate bill
		Then amount per person should be "21.32"