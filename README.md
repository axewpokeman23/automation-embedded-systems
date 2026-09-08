---
ITAE6.100 Automation and Embedded Systems
Assignment - Part 2: Control Systems

BY MARAEA AND SARA
---
# Simple Boiler Controller:<br>Operating Manual

#### Table of Contents
1. [Introduction](#introduction)
  1.1 [Scope](#scope)
  1.2 [Requirements](#requirements)
2. [Getting Started](#getting-started)
  2.1 [Temperature Control](#temperature-control)
  2.2 [Start Heating / Setpoint](#start-heating--setpoint)
  2.3 [Stop Heating](#stop-heating)
3. [Safety Operations](#safety-operations)
  3.1 [Emergency Stop](#emergency-stop)
  3.2 [Pressure Switch](#pressure-switch)


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



