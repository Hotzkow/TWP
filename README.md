# Testing with Way-Points (TWP)

# Repository Outline

This repository contains all exploration results of our experiments, this includes:
* the [exploration models](experiments/prototype-results/); i.e. the trace(s) of actions that were executed, the states which were extracted after each action list all UI elements present, screenshots of each state (named by their causative action-id)
* [usage scenarios](experiments/scenarios) (in Gherkin syntax)
* minimal test executions that were used as [oracle](experiments/test-oracle)
* our prototype (uploaded to docker hub) which can be executed with arbitrary apps and scenarios
* the [apps](experiments/apks) which we used to run our experiments

All (interactive plotly) charts for our experimental results can be investigated in an jupyter notebook [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/Hotzkow/Testing-with-Way-Points/blob/main/experiments/Evaluation.ipynb?flush_cache=True)


# Prototype
## Setup

We provide our prototype and the used language service as docker containers.
As default, we assume that both are executed on the same host machine.
To host the language service on a different computer you have to change the [configuration](#configuration) and ensure that the configured port (default :1234) is accessible to the computer that is running our prototype.

### Requirements

Loading the word2vec model (and possibly launching an Android emulator) is quite memory intensive. 
Therefore, we suggest to use a computer with at least 8GB RAM.
If you intent to use an emulator, we suggest to enable [hardware acceleration](https://developer.android.com/studio/run/emulator-acceleration).

1. Adb version 1.0.41 has to be installed and running on the host pc
	- you can down download it with Android platform-tools v30.0.3 for [linux](http://dl.google.com/android/repository/platform-tools_r30.0.3-linux.zip), [windows](http://dl.google.com/android/repository/platform-tools_r30.0.3-windows.zip), [mac](http://dl.google.com/android/repository/platform-tools_r30.0.3-darwin.zip)  
	- add the location of the adb binary at platform-tools/adb to your $PATH environment variable  
	- start the adb server via `adb start-server`
2. Connect an Android device or start an emulator and check with `adb devices` that
	When a physical device is connected, it will ask your permission to allow the adb connection, you have to agree to this
3. Set an environment variable `DEVICE_SERIAL` to the serial number of the device that you want to use for testing (the serial number is displayed when executing `adb devices`), e.g. for linux `export DEVICE_SERIAL=emulator-5554`
4. Docker and docker-compose (v3.7+) should be installed.
5. You find a docker-compose file in the directory prototype.
	Change the [Configuration](#configuration) to execute your own scenarios or apps.
	Then, you can use the docker-compose file to start our prototype via  
	`docker-compose -f <PATH_TO_DOCKER-COMPOSE_FILE> up`


## Configuration

The docker container of our prototype has to run in "host" network mode such that it can access the Android device or emulator which is connected to your host computer.
Please ensure that your network/firewall configuration does not block the communication between the docker container and the host pc.

We provide a default configuration file at prototype/docker-mnt/config.properties, the relevant options are explained in that file.

### 1. Changing Commandline Arguments

The files provided were tested on ubuntu and windows (with WSL) and should work for mac machines as well.
To pass arguments to the container invocation you can modity the `command` entry in the docker-compose file.
The most relevant optins are

* The path to the configuration file  
	`--Core-configPath=<path_within_container>`
* The similarity threshold (semantic similarity values lower than the threshold are not considered matches) can be changed with  
	`--similarityThreshold=<value between -1 and 1>`
* The directory where the generated execution (models) are placed should be set according to the volume mount point (i.e. our docker-compose configuration specifies /mnt as mount point)  
	`--Output-outputDir=<path_within_container>`
* The serial number of the device to be used (default is set to $DEVICE_SERIAL)  
	`--Exploration-deviceSerialNumber=<adb_device_id>`

## Executing the Prototype

Our prototype uses a language service which computes the cosine similarity for any two strings. 
Due to it's long setup time, this service is encapsulated into it's own docker container. It only has to be started once and can be reused for multiple invocations of the prototype container.

The docker-mnt directory in this repository is only a demonstration on how to pass the configuration, scenarios and apks.

To execute our prototype on a scenario:
1. replace the demo-scenario.feature accordingly to the test scenario (if you rename it, don't forget to adapt the conficurationfile prototype/docker-mnt/config.properties respectively)
2. put your test apk files into the apks directory
3. adapt the configuration to your preferences

For ease of use we provide a docker-compose configuarion which can be used. Please ensure all [requirements](#Requirements) are fullfilled before starting the prototype via  
```bash
export DEVICE_SERIAL=<device id as reporteb by adb devices>
docker-compose up
```
If the language service is already running, you can (re-)start the prototype via `docker-compose up guido`

## Specifying Way-Points

If the scenario file ends with `.feature` it will be interpreted as Gherkin, otherwise as list of action data tuples.

### Gherkin Syntax

Example 1:
```gherkin
Feature: Account Management

	Scenario: Valid Email Credentials
		When type '@email' Into Email/username
		And enter "sample42P!" Into password

	...
	Scenario: Registration
		When click create your account
		* do @scenario: Valid Email Credentials
		* continue
		* do @scenario: Personal Data
		* click submit/signup
		Then @Personal_Data is present in Account Profile
```
Example 2:
```gherkin
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
```

* has to start with the keyword `Feature:` followed by some text (e.g. the feature to be tested)
* one or more `Scenario:` entries have to be defined (e.g. for each usage scenario)
* The first step in the scenario has to start with `when`, further steps can be defined as list (by * prefix) or be concatenated with `and`
* other scenarios can be referenced within steps via `do @scenario: <scenario name>` or you can specify that they should be executed before a scenario by `Given @<Scenario_Name>` (see Example 2)
* to define data to be inserted into a target input field you can define a step of the form `type 'data' target description`, all other steps will be interpreted as target descriptions to define click targets
* the scenario can either end with it's last step to be executed or with a `Then` instruction to define an expected state (though this instruction doesn't have an effect yet as semantic oracle checks are still under development)




### Action Data Tuples (ATDs)

Files in ATD format have to contain at least one macro header before any way-point definition. 
Each line is either empty, defines a way-point or a macro header (indicated by a leading #) e.g. 

```
# scenarioName
click "login"
enter "email" "user@mail.com"
...
```
