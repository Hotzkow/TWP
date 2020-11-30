Feature: manage tasks

	Scenario: Add Task
		When add task item
		* type 'test task' Into task item title 
		* confirm
		Then 'test task' is present 

	Scenario: Remove Task
		Given @Add_Task
		When select test task
		And delete item
		And confirm
		Then 'test task' is not present