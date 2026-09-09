# Part 2: Control Systems

Over the course of weeks 7-8, we worked on this part of the assessment in our own times from Monday, Tuesday and Wednesday.

## Challenges we faced: 

- bang-bang not working correctly
    - managed to fix it by revising the logic and correcting if statements

- mismatched hardware
    - red wire went to the green button and green wire went to the red button
    - fixed by swapping the wires around, but caused a lot of confusion for the first half of trying to program the board

- PID 
    - entering different numbers would overshoot the heater and cause errors

- angle out of range:
    - had issues with the servo where the angle variable parsed to the servo would throw an error. fixed by wrapping in a "run only if within range"

## Member contribution:

### Sara:

Did majority of coding, refactoring and made code more comprehensive, and implemented the PID controller. Also helped to explain aspects of the assignment which were otherwise hard to understand.

- cleaned up code and made it more presentable and easier to read
    - implemented start-up instructions interface (with the help text)
    - fixed state logic (and adjusted names and functions to fit assignment requirements and circuit diagram) 
- had a lot more understanding of the requirements in the assignment, and helped to incorporate it into the code (Water valve/servo (what the valve should do, etc), bang-bang, PID controller)
- created and troubleshooted code in her own time at home

### Maraea:

Wrote initial code which would be built on in later iterations (implementing bang-bang, PID controller, servo/water valve logic)

- initial coding and logic setup
    - code very messy in early stages, but every time, sara refactored the code and made it work and easier to understand
    - created state logic
