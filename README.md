# automation and embedded systems

[current code on the board:](code.py)

## guide
below are functions related to the boiler controller

variables:
SETPOINT = temperature set by buttons ( defaults at 80 )
state = can be RUNNING_STATE or OFF_STATE

### Green button :
- turns on heating
- when heating is on, rotate dial to adjust temperature to match the SETPOINT (temperature set by up down buttons)

### Red button:
- turns off heating


