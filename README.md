<i><p style="font-size:8">ITAE6.100 Automation and Embedded Systems<br>Assignment - Part 2: Control Systems<br>By Maraea and Sara</i></p>

# Simple Boiler Controller:<br>Operating Manual

#### Table of Contents

[1.0 - Introduction](#10-introduction)<br>
[1.1 - Overview](#11-overview)<br>
[2.0 - Hardware and I/O Mapping](#20-hardware-and-io-mapping)<br>
[2.1 - I/O Mapping](#21-io-mapping)<br>
[2.2 - Hardware Wiring](#22-hardware-wiring)<br>
[3.0 - System Operations](#30-system-operations)<br>
[3.1 - State Machine](#31-state-machine)<br>
[4.0 - Safety Operations](#40-safety-operations)<br>
[4.1 - Emergency Stop](#41-emergency-stop)<br>
[4.2 - Pressure Switch](#42-pressure-switch)<br>
[5.0 - Control Operations](#50-control-operations)<br>
[5.1 - Temperature Control](#51-temperature-control)<br>
[5.2 - Start/Stop](#52-startstop)<br>
[5.3 - Operating Instructions](#-53-operating-instructions)<br>
[5.4 - Operations Testing](#54-operations-testing)<br>
[6.0 - PID Control](#60-pid-control)<br>
[6.1 - PID Parameters](#61-pid-parameters)<br>
[6.2 - PID Testing](#62-pid-testing)<br>
[6.3 - PID Suitability](#63-pid-suitability)<br>
[7.0 - Group Contribution](#70-group-contribution)<br>
[8.0 - References](#80-references)<br>
<!--[4.0 - Code explanations](#40-code)<br>-->

## 1.0 Introduction

This report documents the development, testing and implementation of the Simple Water Boiler Controller case study.<br>
The project involved connecting the required hardware to the Raspberry Pi Pico/PLC device, mapping the inputs and outputs, developing a CircuitPython program, and implementing a PID controller for temperature regulation.<br>
- Current code on the board [code.py](code.py)

### 1.1 Overview

The aim of this project is to develop a control system for a simulated water boiler.<br>
The system will be programmed using CircuitPython and tested using the connected hardware to demonstrate that the required inputs, outputs and control functions operate as intended.<br>


## 2.0 Hardware and I/O Mapping

The control system was implemented using the Waveshare RP2350-POE-ETH-8DI-8RO board. The board is based on the Raspberry Pi RP2350 microcontroller.
<br>
Simple control system for a water boiler simulation. 
The system contains 6 inputs to control the associating 8 outputs.<br>

#### Labeled diagrams:

![place labeled image of buttons](images/diagram-of-button.png)

![place labeled board image here](images/diagram-of-board.png)

##### Inputs include:

1. Heating ON / temperature setpoint
2. Heating OFF
4. Temperature Up
5. Temperature Down
6. Emergency Stop
7. Pressure Switch
8. Thermister

##### Outputs include:

1. Heater
2. Temperature Range Indicators (LED1-6)
3. Emergency LED
4. Water valve

##### Additional inputs/outputs:

1. **RGB LED**
    - Upon board receiving power, LED flashes colours before turning back off.
    - LED is green when heating is on
    - LED changes colour according to temperature adjustment for visual feedback.

2. **Buzzer**
    - Upon board receiving power, plays a start-up tune.
    - Simulates an emergency buzzer when: emergency stop has been activated, temperature is being adjusted, or temperature setpoint is attempted to be set to above or below a certain threshold.

### 2.1 I/O Mapping

The components were mapped to the PLC/Pico inputs and outputs using the provided pinout documentation and waveshare.py.

|Component|Type|IO Mapping|GPIO|Description|
|-|-|-|-|-|
|Start - Green button|Digital Input|IX0|DI1|Sets temperature setpoint and enters the RUN_STATE/heating.|
|Stop - Red button|Digital Input|IX1|||Stops heating and enters the STOPPED_STATE.|
|Temperature Up - Blue button|Digital Input|IX3||Increases temperature setpoint.|
|Temperature Down - Yellow button|Digital Input|IX4||Decreases temperature setpoint.|
|Emergency Stop - Black button|Digital Input|IX2|||
|Pressure Switch - Dupont Wire|Digital Input|IX5|||
|Temperature Simulation Dial|Analogue Input|3V3(white), G(purple), 40(gray)|||Simulates the boiler temperature.|
|Water Valve - Servo|Output|39(yellow),3V3(orange),G(brown)||Controls the water valve position/angle.|
|Heater LED|Digital Output|QX0||Indicates heating.
|LED1|Digital Output|QX1|
||Temperature range indicator(80C)|
|LED2|Digital Output|QX2|||Temperature range indicator(100C)|
|LED3|Digital Output|QX3|||Temperature range indicator(120C)|
|LED4|Digital Output|QX4|||Temperature range indicator(140C)|
|LED5|Digital Output|QX5|||Temperature range indicator(160C)|
|LED6|Digital Output|QX6|||Temperature range indicator(180C)|
|Emergency LED|Digital Output|QX7||Indicates EMERGENCY_STATE|

**Note**: Odd temperatures (e.g. 90, 110, 130, 150, 170) trigger two LEDs, and are indicated by both neighbouring LED's being active.

### 2.2 Hardware Wiring

The required buttons, LEDs, servo and temperature sensor were connected to the PLC according to the I/O Mapping above. We also used a mini flathead screwdriver to adjust the screws to secure the different wiring to the board.
<br>

>[!NOTE]:
> The GREEN button uses the red wire and the RED button uses the green wire.
<br>

**Hardware Testing**<br>
As we implemented the CircuitPython code, we tested each button until we achieved the desired outcome.
Video proof is in attached folder [images](images), and can also be seen under header [5.4 - Operations Testing](#54-operations-testing).

## 3.0 System Operations

### 3.1 State Machine

The system has 3 states. Below are the criteria to activate each state: <br>

**1. STOPPED_STATE**

Input functionality:
   * Temperature control buttons press: enabled
   * Start button press: enabled
   * Stop button press: disabled
   * Emergency button press: disabled
   * Pressure switch: disabled

Output functionality:
   * Heater control is disabled

**2. RUN_STATE**

Input functionality:
   * Temperature control buttons press: disabled
   * Start button: active
   * Stop button press: enabled
   * Emergency button press: enabled
   * Pressure switch: enabled

Output functionality:
   * Heater control is active

**3. EMERGENCY_STATE**

Input functionality:
   * Temperature control buttons press: disabled
   * Start button press: disabled
   * Stop button press: disabled
   * Emergency button press: active
   * Pressure switch: active emergency state

Output functionality:
   * Heater control is disabled

## 4.0 Safety Operations

### 4.1 Emergency Stop

> [!CAUTION]
>  Pressing the BLACK button will activate ***emergency stop***. When activated, the system enters the EMERGENCY_STATE. This ceases all interactivity and functions of the buttons (temp up, down, heating start, stop), activates a continuous buzzer, disables the heater, and fully closes the water valve to 0%.

To **EXIT emergency stop mode** and resume normal function, the BLACK and RED buttons must be pressed simultaneously.

### 4.2 Pressure Switch

The pressure switch triggers the same emergency response as the emergency stop. When activated, the system enters the EMERGENCY_STATE. This activates a continuous buzzer, disables the heater, and fully closes the water valve to 0%.

This event is simulated using a DuPont pin to trigger the input.

## 5.0 Control Operations

### 5.1 Temperature Control

The temperature setpoint can be adjusted using the BLUE button to increase the setpoint and the YELLOW button to decrease the setpoint.

The system allows for a minimum setpoint of 80C and a maximum setpoint of 180C.

### 5.2 Start/Stop

Pressing the GREEN button activates heating, while the RED button will deactivate heating.
Starting the heating will send a signal to output relay ***RO1***.

### 5.3 Operating Instructions 

1. Select the desired temperature using the BLUE and YELLOW buttons.
2. Press the GREEN button to set the temperature and start heating.
3. The system monitors the boiler temperature and controls the heater.
4. Press the RED button to stop heating.
5. In an emergency, press the BLACK button to activate the emergency stop.
6. To reset the emergency stop, press the BLACK and RED buttons simultaneously.

The REPL will display feedback for each valid action.

### 5.4 Operations Testing

The following table contains evidence that each operation works as intended.

|Test|Expected Result|Pass/Fail|Evidence|
|-|-|-|-|
|Blue button|Setpoint increases|Pass|[temp up/down](./images/tempup_tempdown.MOV)|
|Yellow button|Setpoint decreases|Pass|[temp up/down](./images/tempup_tempdown.MOV)|
|Green button|Activates RUN_STATE|Pass|[start/stop](./images/start_stop.MOV)|
|Red button|Activates STOPPED_STATE|Pass|[start/stop](./images/start_stop.MOV)|
|Black button|Activates EMERGENCY_STATE|Pass|[emergency stop](./images/emergency.MOV)|
|DuPont (Pressure Switch)|Activates EMERGENCY_STATE|Pass|[url]|
|Temperature dial|Simulate temperature changes|Pass|[url]|
|PID Control|Controls/stabilises the temperature|Pass|[url]|
|Servo|Opens/closes correctly|Pass|[url]|

## 6.0 PID Control

A PID controller was implemented to control the simulated boiler temperature.
The controller compares the selected temperate setpoint with the temperature provided by the simulation dial and adjusts the heater output based on the temperature error.

The PID controller was tested by observing the boiler temperature as it approached the selected setpoint.

### 6.1 PID Parameters

Kp: 2
Ki: 0.001
Kd: 0.01

The PID parameters were adjusted through testing to achieve a low error when the boiler temperature reaches the desired setpoint.

### 6.2 PID Testing 

To test how the PID works, the Kp, Ki and Kd was each changed incrementally to output a minimal temperature error when the boiler temperature reaches the setpoint. 

Challenges were experienced when changing these inputs to received the correct results. Firstly, the PID, specifically the Integral was much higher and therefore the PID heating output completely overshot the desired setpoint, resulting in the following screenshot where the heating output is [percent] when the temperature [actual_temp]() had already reached the setpoint [setpoint]().
<br>

Kp: 2<br>
Ki: 0.02<br>
Kd: 0.01<br>

The following screen recording displays the Heating Control Status and outputs the PID % and temperature error.<br>

![REPL screen recording displaying heating outputs](./images/REPL_output.mp4)

### 6.3 PID Suitability

PID control can be suitable for embedded systems such as smart water boilers, where a microcontroller can continuously monitor temperature and adjust the heating output. This is especially important for industrial water-heating systems, where accurate temperature control is required. 
<br>
However, PID is not always necessary. A basic domestic water heater may only require a simple bang-bang (ON/OFF) control method to maintain the temperature within an acceptable range.
<br>
For this project, both PID and bang-bang control were implemented. Because our system uses a simple ON/OFF LED to simulate the heater, bang-bang is more suitable for this scenario.
<br>

## 7.0 Group Contribution

<br>
Both members participated and contributed for every step of the project such as the hardware wiring, implementing CircuitPython code, testing PID controller, recording evidence and documentation during this project.
<br>

![Part 2](part2-documentation.md)

## 8.0 References

https://github.com/Copper280z/CircuitPython_simple-pid/blob/master/examples/water_boiler/README.md
