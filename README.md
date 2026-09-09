<i><p style="font-size:8">ITAE6.100 Automation and Embedded Systems<br>
Assignment - Part 2: Control Systems<br>
By Maraea and Sara</i></p>
<br>
# Simple Boiler Controller:<br>Operating Manual

#### Table of Contents
1. [Introduction](#introduction)<br>
1.1 [Scope](#scope)<br>
1.2 [Requirements](#requirements)<br>
2. [Getting Started](#getting-started)<br>
2.1 [Temperature Control](#temperature-control)<br>
2.2 [Start Heating / Setpoint](#start-heating--setpoint)<br>
2.3 [Stop Heating](#stop-heating)<br>
3. [Safety Operations](#safety-operations)<br>
3.1 [Emergency Stop](#emergency-stop)<br>
3.2 [Pressure Switch](#pressure-switch)<br>


## 1. Introduction 

- [current code on the board:](code.py)
- [to-do](todo.md)

### 1.1 Scope
Simple control system for a water boiler simulation. The system contains 6 inputs to control the associating 8 outputs.

### 1.2 Requirements
Inputs include:
- Heating ON / temperature setpoint
- Heating OFF
- Temperature Up
- Temperature Down
- Emergency Stop
- Pressure Switch

## Getting Started
Power source USB
System will power on immediately, greeted with ringtone and flashing lights and message

### Temperature Control
Control temp buttons

### Start Heating / Setpoint

### Stop Heating

## Safety Operations
### Emergency Stop
### Pressure Switch



**INSTRUCTIONS:**<br>
Please select a temperature using the BLUE button for UP and the YELLOW button for DOWN.
Press the GREEN button to start heating and the RED button to stop heating.

*-------------------IMPORTANT:----------------------*<br>

In case of an EMERGENCY, press the BLACK button to enable the EMERGENCY STOP.<br>
To disable the EMERGENCY STOP, press the BLACK and RED button simultaneously.<br>

----------------------------------------------------

below are functions related to the boiler controller

### variables:
SETPOINT = temperature set by buttons ( defaults at 80 )
state = can be RUNNING_STATE or OFF_STATE

### Green button :
- turns on heating-state
- when heating is on, rotate dial to adjust temperature to match the SETPOINT (temperature set by up down buttons)

  #### features:
  If SETPOINT and temperature of the boiler are not the same:
  - heating is turned on
 
  if SETPOINT and temperature of the boiler are within a few degrees of eachother OR
  if temperature of the boiler goes above SETPOINT:
  - heating is turned off and "no longer needed".
 
  idea: if temperature of the boiler goes above 180 and above SETPOINT:
  - enforce emergency stop??? just an idea

### Red button:
- turns off heating
- allows for temperature setting

### Black button:
- emergency stop



