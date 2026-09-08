# automation and embedded systems
WATER BOILER PROJECT
BY MARAEA AND SARA

- [current code on the board:](code.py)
- [to-do](todo.md)

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



