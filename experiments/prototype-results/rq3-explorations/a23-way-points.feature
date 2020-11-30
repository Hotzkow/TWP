Feature: manage tasks

	Scenario: Delete Task
		When click Skip
		* add new task
		# has sim=0.3510 to the field 'description', if it's not supposed to be filled the threshold should be chosen higher
		* type 'test task' Into Name
		* okay
		# requires long click, right now no fixed specification for this
		* select test task
		* delete To-Do Task
