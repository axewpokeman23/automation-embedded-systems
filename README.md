# automation and embedded systems

[current code on the board:](code.py)

## [working code:](e_stop.py)

right now, it contains a lot of test code
1. must press the green button first to make it work.
2. can be switched back off using the black button


#### green button - start button:
- turns on "RUN STATE"
- makes LED green

#### red button - stop button:
- E_STOP_SWITCH MUST be off for this button to work
- for testing: pressing it will show the current temperature

#### black button - emergency stop:
- E_STOP_SWITCH must be off for this button to work
- turns on E_STOP_SWITCH and stops all functionality
- pressing the green button turns E_STOP_SWITCH back off and puts it in "run state" again

#### blue button - temperature up:
- ONLY works if temperature is not over 180 (must add "cannot go under 0")
and runstate is on
- E_STOP_SWITCH must be off for this button to work
- goes up by increments of 10

#### yellow button - temperature down:
- should ONLY work if temperature is not less than zero (but i havent added that yet)
and runstate is on
- goes down by decrements of 10
- E_STOP_SWITCH must be off for this button to work
