<i><p style="font-size:8">ITAE6.100 Automation and Embedded Systems<br>Assignment - Part 3: Programming with a PLC<br>By Maraea and Sara</i></p>

# Simple Boiler Controller

#### Table of Contents

[1.0 - Introduction](#10-introduction)<br>
[2.0 - Hardware and I/O Mapping](#20-hardware-and-io-mapping)<br>
[2.1 - I/O Mapping](#21-io-mapping)<br>
[3.0 - System Operations](#30-system-operations)<br>
[4.0 - Testing](#40-testing)<br>

## 1.0 Introduction

This report documents Part 3 of the Simple Water Boiler Controller case study. Previously, we used Logisim and CircuitPython to implement the case study logic. 
Part 3 aims to implement the case study logic using a combination of ladder diagrams (LD) and function block diagrams (FBD) using the OpenPLC software. 

We will be using the Custom Raspberry Pico W PLC to test the connected hardware (digital, and analogue inputs, and outputs) and to demonstrate that the PLC is functioning as intended.

## 2.0 Hardware and I/O Mapping

The system contains 8 inputs to control the associating 9 outputs.<br>
##### Inputs include:

1. Start / Heating ON / Setpoint
2. Stop / Heating OFF
4. Temperature Up
5. Temperature Down
6. Emergency Stop
7. Pressure Switch
8. Thermister(Temperature simulated with dial)

##### Outputs include:

1. Heater LED
2. Temperature Range Indicators (Relays / LED0-5)
3. Emergency LED
4. Servo(Water valve)

picture of board and inputs 

### 2.1 I/O Mapping

The following displays the input and output mapping used.

|**Inputs**|Type|Wire|Board Label|GPIO Pin|I/O Mapping|
|-|-|-|-|-|-|
|Start Button (GREEN)|Digital Input<br>(Discrete Input Contacts)|**Red**|DI-1|6|IX0.0|
|Stop Button (RED)|Digital Input<br>(Discrete Input Contacts)|**Green**|DI-2|7|IX0.1|
|Emergency Stop (BLACK)|Digital Input<br>(Discrete Input Contacts)|Black|DI-3|8|IX0.2|
|Temp Up (BLUE)|Digital Input<br>(Discrete Input Contacts)|Blue|DI-4|9|IX0.3|
|Temp Down (YELLOW)|Digital Input<br>(Discrete Input Contacts)|Yellow|DI-5|10|IX0.4|
|Pressure Switch (DuPont)|Digital Input<br>(Discrete Input Contacts)|Yellow DuPont|DI-6|11|IX0.5|
|Temp Dial|Analogue Input<br>(Input Register)|Purple<br>Grey<br>White|GND<br>AD0<br>3V3|26|IW0.0|

**Note:** Start and Stop button wires are opposite.

|**Outputs**|Type|Wire|Board Label|GPIO Pin|I/O Mapping|
|-|-|-|-|-|-|
|Heater LED|Digital Output<br>(Discrete Output Coil)|-|DO-1 / LED4|21|QX0.0|
|LED0|Digital Output<br>(Discrete Output Coil)|-|DO-2 / LED5|20|QX0.1|
|LED1|Digital Output<br>(Discrete Output Coil)|-|DO-3 / LED6|19|QX0.2|
|LED2|Digital Output<br>(Discrete Output Coil)|-|DO-4 / LED7|18|QX0.3|
|LED3|Digital Output<br>(Discrete Output Coil)|-|DO-5 / LED8|17|QX0.4|
|LED4|Digital Output<br>(Discrete Output Coil)|-|DO-6 / LED9|16|QX0.5|
|LED5|Digital Output<br>(Discrete Output Coil)|-|DO-7 / LED10|15|QX0.6|
|Emergency LED|Digital Output<br>(Discrete Output Coil)|-|DO-8 / LED11|14|QX0.7|
|Servo (Water Valve)|Analogue Output<br>(Holding Register)|Brown<br>Red<br>Yellow|GND<br>5V<br>PMW|4|QW0.0|

## 3.0 System Operations

> [!NOTE]  
> The following information in this section iterates the logic from the previous tasks and case study.<br>
> Click toggle below to expand this information, or skip to [Testing](#40-testing).<br>

<details>
   <summary>Click to view System Operations information</summary>

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

### 3.1 Emergency Stop

Pressing the BLACK button will activate the emergency stop ***(EMERGENCY_STATE)***. When activated, the system enters the EMERGENCY_STATE. This activates a continuous buzzer, disables the heater, and fully closes the water valve to 0%.<br>
**To disable the emergency stop, the BLACK and RED buttons must be pressed simultaneously.**

### 3.2 Pressure Switch

The pressure switch triggers the same emergency response as the emergency stop. When activated, the system enters the EMERGENCY_STATE. This activates a continuous buzzer, disables the heater, and fully closes the water valve to 0%.

This event is simulated using a DuPont pin to trigger the input.

### 3.2 Temperature Control

The temperature setpoint can be adjusted using the BLUE button to increase the setpoint and the YELLOW button to decrease the setpoint.

The system allows for a minimum setpoint of 80C and a maximum setpoint of 180C.

### 3.3 Start/Stop

Pressing the GREEN button activates heating, while the RED button will deactivate heating.
Heating is indicated by the output relay DO-1 / LED 4.<br>
If the temperature is above the SETPOINT, the heater relay / LED will turn off and vice versa. 

### 3.4 Operating Instructions 

1. Select the desired temperature using the BLUE and YELLOW buttons.
2. Press the GREEN button to set the temperature and start heating.
3. The system monitors the boiler temperature and controls the heater.
4. Press the RED button to stop heating.
5. In an emergency, press the BLACK button to activate the emergency stop.
6. To reset the emergency stop, press the BLACK and RED buttons simultaneously.

</details>

## 4.0 Testing

The following table contains evidence that each operation works as intended. Modbus was also used to confirm that the inputs, coils and holding registers were working correctly.

|Test|Expected Result|Pass/Fail|Evidence|
|-|-|-|-|
|Blue button|Setpoint increases|||
|Yellow button|Setpoint decreases|||
|Green button|Activates RUN_STATE|||
|Red button|Activates STOPPED_STATE|||
|Black button|Activates EMERGENCY_STATE<br>Black and Red button to disable EMERGENCY_STATE|||
|DuPont (Pressure Switch)|Activates EMERGENCY_STATE|||
|Temperature dial|Simulate temperature changes|||
|Servo|Opens/closes correctly|||
|PID Control|Controls/stabilises the temperature|||
|Modbus|Displays inputs, coils, holding registers and input registers|||
|Runtime|Displays |||


<!--
connected by SERIAL COM11
>