# Part 2: Control Systems

For this assessment, we had to program code that would work on a microcontroller to fulfill the requirements as specified in the assignment handout for a smart water boiler.
We worked on this part of this assessment for all of weeks 7-8.

## Challenges we faced: 

- bang-bang not working correctly
    - managed to fix it by revising the logic and correcting if statements

- mismatched hardware
    - red wire went to the green button and green wire went to the red button
    - fixed by swapping the wires around, but caused a lot of confusion for the first half of trying to program the board

- PID 
    - entering different numbers would overshoot the heater and cause errors
    - Super confusing to understand, but would be completed by Sara - Maraea

- angle out of range:
    - had issues with the servo where the angle variable parsed to the servo would throw an error. fixed by wrapping in a "run only if within range"

## Member contribution:

### Sara:

Did majority of coding, refactoring and made code more comprehensive, and implemented the PID controller. Also helped to explain aspects of the assignment which were otherwise hard to understand.
Brought board home so she could work on it in her own time.

- cleaned up code and made it more presentable and easier to read
    - implemented start-up instructions interface (with the help text)
    - fixed state logic (and adjusted names and functions to fit assignment requirements and circuit diagram) 
- had a lot more understanding of the requirements in the assignment, and helped to incorporate it into the code (Water valve/servo (what the valve should do, etc), bang-bang, PID controller)
- created and troubleshooted code in her own time at home

### Maraea:

Wrote initial code to be built on in later iterations (first working iteration of the code, implementing bang-bang logic and "if temp within range of setpoint + or - 2 degrees" ... etc). Worked on it on the mondays, tuesdays and wednesdays of week 7 and 8.

- initial coding and logic setup
    - code very messy in early stages
    - created state logic
    - implemented bang-bang logic
