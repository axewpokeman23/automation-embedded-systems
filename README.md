<i><p style="font-size:8">ITAE6.100 Automation and Embedded Systems<br>Assignment - Part 3: Programming with a PLC<br>By Maraea and Sara</i></p>

# Simple Boiler Controller

#### Table of Contents

[1.0 - Introduction](#10-introduction)<br>
[1.1 - Overview](#11-overview)<br>
[2.0 - Hardware and I/O Mapping](#20-hardware-and-io-mapping)<br>
[2.1 - I/O Mapping](#21-io-mapping)<br>
[3.0 - System Operations](#30-system-operations)<br>

## 1.0 Introduction

### 1.1 Overview

## 2.0 Hardware and I/O Mapping

picture of board and inputs 

### 2.1 I/O Mapping

|**Inputs**|Type|Wire|Board Label|GPIO Pin|I/O Mapping|
|-|-|-|-|-|-|
|Start Button (GREEN)|Digital Input(Discrete Input Contacts)|**Red**|DI-1|6|IX0.0|
|Stop Button (RED)|Digital Input(Discrete Input Contacts)|**Green**|DI-2|7|IX0.1|
|Emergency Stop (BLACK)|Digital Input(Discrete Input Contacts)|Black|DI-3|8|IX0.2|
|Temp Up (BLUE)|Digital Input(Discrete Input Contacts)|Blue|DI-4|9|IX0.3|
|Temp Down (YELLOW)|Digital Input(Discrete Input Contacts)|Yellow|DI-5|10|IX0.4|
|Pressure Switch (DuPont)|Digital Input(Discrete Input Contacts)|Yellow DuPont|DI-6|11|IX0.5|

**Note:** Start and Stop button wires are opposite.

|**Outputs**|Type|Board Label|GPIO Pin|I/O Mapping|
|-|-|-|-|-|
|Heater LED|Digital Output(Discrete Output Coil)|DO-1 / LED4|21|QX0.0|
|LED0|Digital Output(Discrete Output Coil)|DO-2 / LED5|20|QX0.1|
|LED1|Digital Output(Discrete Output Coil)|DO-3 / LED6|19|QX0.2|
|LED2|Digital Output(Discrete Output Coil)|DO-4 / LED7|18|QX0.3|
|LED3|Digital Output(Discrete Output Coil)|DO-5 / LED8|17|QX0.4|
|LED4|Digital Output(Discrete Output Coil)|DO-6 / LED9|16|QX0.5|
|LED5|Digital Output(Discrete Output Coil)|DO-7 / LED10|15|QX0.6|
|Emergency LED	Digital Output(Discrete Output Coil)|DO-8 / LED11|14|QX0.7|

|**Analogues**|Type|Wire|Board Label|GPIO Pin|I/O Mapping|
|Temp Dial|Analogue Input(Analogue Input Register)|Purple, Grey, White|GND, AD0, 3V3|26|IW0.0|
|Servo (Water Valve)|Analogue Output|Brown<br>Red<br>Yellow|GND<br>5V<br>PMW|4|QW0.0|

**Note:** AD0 is Channel 1.

## 3.0 System Operations

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
