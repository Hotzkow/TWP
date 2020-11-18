
# Setup

We provide our prototype and the used language service as docker containers.
As default, we assume that both are executed on the same host machine (this can be changed [see configuration](#configuration)).

## Requirements
1. Loading the word2vec model (and possibly launching an Android emulator) is quite memory intensive.
Therefore, we suggest to use a computer with at least 8GB RAM.
2. Docker and docker-compose (v3.7+) should be installed
3.
	- When using an emulator, we suggest to enable [hardware acceleration](https://developer.android.com/studio/run/emulator-acceleration).
	- If the host is no unix machine you cannot use the option `emulator` (to launch the emulator within the docker container).
	Therefore, you have to launch the emulator on your host or connect a physical device; have adb running on the host; ensure a docker container can connect to this host device; and change the [configuration](#configuration) from `emulator` to `winHost`,`macHost` or `unixHost` (to use the external device).


# Configuration

Our prototype can be configured in two ways:
1. as commandline argument (which take priority over any configuration file)
2. within a configuration file


We provide a default configuration file at ./volume/config.properties, the relevant options are explained in that file.

## 1. Changing Commandline Arguments
To pass arguments to the container invocation you can modity the `command` entry in the docker-compose.yml` file.

!!! Hint The first parameter has to be one of [`emulator`, `winHost`, `macHost`, `unixHost`]. 
	* `emulator`: the container will launch it's own instance of an Android emulator
	* `winHost`, `macHost`, `unixHost`: please select the option according to your host's operating system since the mechanics to access the host IP address from within docker differs,
	but this IP address is necessary to communicate with the hosts Android device.

!!! Warning Emulator within Docker
	We highly discourage the use of this option if no stable emulator launch from within a docker container can be verified (reasoned by 2.) or multiple instances are created and only the successful ones are selected in a post processing step.
	1. This option is only possible for linux host machines
	2. Please note, that this modus is error prone (i.e. the emulated device may display a not responding error) and thus the prototype has terminate early and not generate meaningfull test actions. 
	In that case you should re-launch the container.

* The path to the configuration file has to be set via  
	`--Core-configPath=<path_within_container>`
* The similarity threshold (semantic similarity values lower than the threshold are not considered matches) can be changed with  
	`--similarityThreshold=<path_within_container>`
* The directory where the generated execution (models) are placed should be set according to the volume mount point (i.e. our docker-compose configuration specifies /mnt as mount point)  
	`--Output-outputDir=<path_within_container>`

# Executing the Prototype

Our prototype uses a language service which provides the cosine distance for any two strings. 
Due to it's long setup time, this service is encapsulated into it's own docker container. It only has to be started once and can be reused for multiple invocations of the prototype container.

For ease of use we provide a docker-compose configuarion which can be invoked via `docker-compose up` (from within the directory where the file is located).
The volume directory in this repository is only a demonstration on how to pass the configuration, scenarios and apks.

To execute our prototype on a scenario:
1. replace the demo-scenario.feature accordingly to the test scenario (if you rename it, don't forget to adapt the configuration respectively)
2. put your test apk files into the apks directory
3. optionally adapt the configuration to your preferences
4. start the container via `docker-compose up`
