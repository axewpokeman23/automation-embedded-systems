# PART 2: CONTROL SYSTEMS (Topics 3 & 4) 25 marks 

### Submission requirements for Part 2 
For Part 2 submission, gather all required materials and place them in a folder named Group*_Part2, where "*" represents your group number. <br> This folder should include short videos (about 10 seconds each) or photos demonstrating the hardware in action, along with written documentation explaining how you addressed challenges during the lab and detailing each team member’s contributions. <br> Additionally, include all code files for Tasks 1 and 2. Once everything is collected, compress the folder into a single ZIP file named Group*- part2.zip for final submission. NOTE: Keep the assembly from the above circuit for the next lab activity 

> needed for documentation:
>> 1. video proof board is working
>> 2. comment on why a pid controller may not be suitable

## Introduction 
The focus of this part of the assessment is on leveraging a Microcontroller to implement a control system, and is based on topics covered in class. <br> 
The objective of this assessment is to demonstrate your ability to use a microcontroller to achieve a set of requirements. <br>Parts of the assessment might require additional research or actions to be able to move forward, e.g. installing or configuring software and reading datasheets. <br>This part of the assessment will continue to use the Case Study Simple Boiler Smart controller.
## Details & Requirements 
This assessment requires you to set up and configure the PLC device with suitable CircuitPython or MicroPython firmware and suitable editor (Thonny (preferred)2 or rvcircuit-studio3) to demonstrate functioning programs using physical hardware. <br> The course assumes CircuitPython but MicroPython is also possible, however you will need to make changes to the starter kit code if you choose to use MicroPython. <br> Some of the CircuitPython resources required for this task can be found in the picoPLC starterkit. <br> You will find the following files that will be used in this activity: <br>
- Pico-OpenPLC-A4-Pinout.pdf or RP2350B_Relay_board_GPIO.xlsx - pinout and GPIO mapping.
- adafruit-circuitpython-raspberry_*.uf2 – CircuitPython firmware for the Raspberry Pico based boards.
- adafruit-circuitpython-waveshare_*.uf2 - CircuitPython firmware for the Waveshare based board.
- code folder – contains sample code and the required boot.py & iomapping*.py file and lib folder for this activity. (waveshare.py and raspberry.py provide an OOP PLC wrapper to the GPIO) 
> To confirm operation on the breadboard, you must take photos/video of the “appliance” in action 

### Task 1: Process control in CircuitPython or MicroPython 
With an understanding of how the case study appliance operates, the next step is to convert the operation into program code. The program will be written in CircuitPython or MicroPython. 
- Install the required files and folders onto the Raspberry Pi Pico
- Map out the case study appliance inputs and outputs to the pinouts as reflected in the Pico-OpenPLC- A4-Pinout.pdf or RP2350B_Relay_board_GPIO.xlsx document and the iomapping.py file. E.g Temperature sensor – %IW0 (analogue input) Water Value actuator - %QW (analogue output)
- Connect the necessary buttons, LEDs, servo and Temperature sensor to the PLC device (ensure the device is not plugged into a computer when setting it up).
- Use the previous mapping to connect the components.
- Use suitable resistors for the LEDs.
- The inputs have an internal pulldown so buttons need to be connected to 3V3 and the GPIO for the Raspberry Pico based boards.
- The buttons need to be connected to DGND and the GPIO for the Waveshare based board.
- Use the PCLcode1.py and rename to code.py to test the inputs and outputs.
- Write a CircuitPython program that best reflects the operation of the case study appliance. [20 marks] <br>2 https://thonny.org/ 3 https://github.com/ArmstrongSubero/rvcircuit-studio

### Task 2: Control system using a PID 
Extend the above program code to include a suitable control system. 
> • Apply a PID controller to ensure the temperature control is maintained. 
> • Comment on why the PID in this scenario may not be the most suitable control system. [5 marks] 
