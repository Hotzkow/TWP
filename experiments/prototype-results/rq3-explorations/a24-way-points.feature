Feature: manage tasks

	Scenario: Delete Task
		When click OK
		* type 'test task' Into New List Name
		* click add
		# delete would actually require a swipe action, but we did enforce the action type from these scenario instructions
		* select test task
		* delete
		* yes