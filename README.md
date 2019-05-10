# Home Sensor Quality Classifier 

CMG Engineering Audition

Prepared by Andy Maleh

## Background

365-Widgets makes inexpensive home sensors such as thermometers, humidistats, and carbon monoxide detectors. In order to spot check the
manufacturing process, some units are put in a test environment (for an unspecified amount of time) and their readings are logged. The test
environment is controlled with a known temperature, humidity, and CO concentration, but the inexpensive sensors are expected to have some
variation with each reading.
As a developer, your task is to process the log files and automate the quality control evaluation.

## Glossary

Sensor: device for measuring home climate conditions. 
Thermometer: sensor that measures temperature
Humidistat: sensor that measures humidity
Carbon monoxide detector: sensor that measures CO concentration
Ultra precise: thermometer classification whereby the mean of the readings is within 0.5 degrees of the known temperature, and the standard deviation is less than 3.
Very precise: thermometer classification whereby if the mean is within 0.5 degrees of the room, and the standard deviation is under 5.
Precise: thermometer classification for thermometers that are neither ultra precise nor very precise
Log file: output of sensor readings

## Business Use Case

* Use Case: Spot check home sensors
 * Trigger: scheduled time event or manual engineer request
 * Steps:
  1. Generate log file from sensor readings to use as input in quality control evaluation
  2. Process log file, identifying reference values, sensors, and their readings
  3. Evaluate quality of each sensor
  4. Generate output containing the sensors and their quality control classification

## System Scope

The system shall only cover steps 2-4 of the business use case. Step 1 is assumed as implemented and the system shall receive its output log file as its input. This is detailed in system use case later on.

## System Boundary Diagram

This just illustrates the boundary (scope) of the system, which will do the processing work to convert inputs into output.

Thermometer Sensor -> 
Humidity Sensor    -> SYSTEM -> Output
CO Level Sensor    -> 

## Requirements Specification

1. For a thermometer, it is branded “ultra precise” if the mean of the readings is within 0.5 degrees of the known temperature, and the standard
deviation is less than 3. It is branded “very precise” if the mean is within 0.5 degrees of the room, and the standard deviation is under 5. Otherwise,
it’s sold as “precise”.
2. For a humidity sensor, it must be discarded unless it is within 1 humidity percent of the reference value for all readings. (All humidity sensor
readings are a decimal value representing percent moisture saturation.)
3. For a carbon monoxide detector, it must be discarded unless it is within 3 ppm of the reference value for all readings. (All carbon monoxide
readings are an integer value representing parts per million.)

An example log looks like the following. The first line means that the room was held at a constant 70 degrees, 45% relative humidity with 6 ppm
carbon monoxide. Subsequent lines either identify a sensor (<type> <name>) or give a reading (<time> <value>).

reference 70.0 45.0 6
thermometer temp-1
2007-04-05T22:00 72.4
2007-04-05T22:01 76.0
2007-04-05T22:02 79.1
2007-04-05T22:03 75.6
2007-04-05T22:04 71.2
2007-04-05T22:05 71.4
2007-04-05T22:06 69.2
2007-04-05T22:07 65.2
2007-04-05T22:08 62.8
2007-04-05T22:09 61.4
2007-04-05T22:10 64.0
2007-04-05T22:11 67.5
2007-04-05T22:12 69.4
thermometer temp-2
2007-04-05T22:01 69.5
2007-04-05T22:02 70.1
2007-04-05T22:03 71.3
2007-04-05T22:04 71.5
2007-04-05T22:05 69.8
humidity hum-1
2007-04-05T22:04 45.2
2007-04-05T22:05 45.3
2007-04-05T22:06 45.1
humidity hum-2
2007-04-05T22:04 44.4
2007-04-05T22:05 43.9
2007-04-05T22:06 44.9
2007-04-05T22:07 43.8
2007-04-05T22:08 42.1
monoxide mon-1
2007-04-05T22:04 5
2007-04-05T22:05 7
2007-04-05T22:06 9
monoxide mon-2
2007-04-05T22:04 2
2007-04-05T22:05 4
2007-04-05T22:06 10
2007-04-05T22:07 8
2007-04-05T22:08 6

Sample Output
{
"temp-1": "precise",
"temp-2": "ultra precise",
"hum-1": "keep",
"hum-2": "discard",
"mon-1": "keep",
"mon-2": "discard"
}

You have been tasked with creating a solution that takes the contents of a log file, and outputs the devices and their classification, as per the sample
output above.

## System Use Case (Detailed Steps)

* Use Case: Spot check home sensors
 * Trigger: method invocation (SensorEvaluator.new(log_contents_str).classify_sensors)
 * Steps:
  1. Process log file line by line, to build up information about reference values and sensors (each including its readings)
  2. For each sensor, for each sensor classification algorithm, evaluate sensor until a classification match is found
  3. Transform the listing of each sensor and its classification into a sensor classification output format

## Object Responsibilities

Identifying object responsibilities will help us discover objects representing domain models.

* Extract reference values from log file
* Extract sensor information (including readings) from log file
* Evaluate all sensors 
* Classify thermometer sensor quality
* Classify humidistat sensor quality
* Classify carbon monoxide detector sensor quality
* Build Sensor Classification Output

## Domain Models

These are identified by assigning object responsibilities above to the appropriate domain models.

- Sensor Evaluator: evaluates all sensors (represents system)
- Log Extractor: extracts reference values and sensor information (including readings) from log file
- Climate Reference: stores current climate reference values relating to temperature, humidity, and CO level.
- Sensor: stores sensor name and readings, and invokes appropriate classification strategy. Comes in 3 types:
 - Thermometer Sensor
 - Humidistat Sensor
 - Carbon Monoxide Detector Sensor
- Sensor Classification Strategy: algorithm that classifies sensor of a particular type, with 3 strategies below:
  - Thermometer Classification Strategy
  - Humidistat Classification Strategy
  - Carbon Monoxide Detector Classification Strategy
- Output Builder: builds sensor classification output in format matching Requirements Specification

#TODO TASKS

- Validations
- Security
- Performance
- Gemify (Jewel?)
