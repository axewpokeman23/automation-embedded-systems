<i><p style="font-size:8">ITAE6.100 Automation and Embedded Systems<br>Assignment - Part 2: Control Systems<br>By Maraea and Sara</i></p>
# Simple Boiler Controller:<br>Operating Manual

#### Table of Contents

[1.0 - Introduction](#10-introduction)<br>
[1.1 - Scope](#11-scope)<br>
[1.2 - Hardware Mapping](#12-hardware-mapping)<br>
[1.3 - Requirements](#13-requirements)<br>
[2.0 - Safety Operations](#20-safety-operations)<br>
[2.1 - Emergency Stop](#21-emergency-stop)<br>
[2.2 - Pressure Switch](#22-pressure-switch)<br>
[3.0 - Getting Started](#30-getting-started)<br>
[3.1 - Temperature Control](#31-temperature-control)<br>
[3.2 - Start Heating / Setpoint](#32-start-heating--setpoint)<br>
[3.3 - Stop Heating](#33-stop-heating)<br>
<!--[4.0 - Code explanations](#40-code)<br>-->

## 1.0 Introduction
Solution implemented as program code on a microcontroller.<br>
- [current code on the board:](code.py)
- [Assignment information - tasks](assignment-breakdown.md)

references: (for the different callouts)
> [!NOTE]
> note

> [!TIP]
> tip

> [!IMPORTANT]
> important

> [!WARNING]
> warning

> [!CAUTION]
> caution

### 1.1 Scope
Simple control system for a water boiler simulation. 
The system contains 6 inputs to control the associating 8 outputs.<br>

> [!IMPORTANT]
> !(place the picture of the board and associated buttons here)[images/full-top-picture.png]
> - outline outputs vs inputs ?

Inputs include:
1. Heating ON / temperature setpoint
2. Heating OFF
4. Temperature Up
5. Temperature Down
6. Emergency Stop
7. Pressure Switch
8. Thermistor

> [!IMPORTANT] image here showing the buttons and input side of the board
> labeled 1 - 8 corresponding to component listed above

Outputs include:
1. Heater
2. Temperature Range Indicators (LED1-6)
3. Emergency LED
4. Water valve

> [!IMPORTANT] image here with full view of the output side of the board
> labeled and circled 1-4

Additional inputs/outputs:
1. RGB LED
  - Upon board receiving power, LED flashes colours before turning back off.
  - LED is green when heating is on

3. Buzzer
  - Upon board receiving power, plays a start-up tune.
  - Simulates an emergency buzzer when: emergency stop has been activated, temperature is being adjusted, or temperature setpoint is attempted to be set to above or below a certain threshold.

> [!IMPORTANT] image here depicting additional inputs/outputs
> labeled and circled RGB and BUZZER

### 1.2 Hardware Mapping

> [!IMPORTANT]
> !(place hardware mapping thing here)[images/hardware-map-diagram.png]

### 1.3 Requirements

The system has 3 states. Below are the criteria to activate each state: <br>

#### 1. STOPPED_STATE - Heating disabled
   * Temperature control buttons press: enabled
   * Start button pres: enabled
   * Stop button press: disabled
   * Emergency button press: disabled
   * Pressure switch: disabled
#### 2. RUN_STATE - Heating enabled
   * Temperature control buttons press: disabled
   * Start button: active
   * Stop button press: enabled
   * Emergency button press: enabled
   * Pressure switch: enabled
#### 3. EMERGENCY_STATE - All interaction disabled until EMERGENCY_STATE is False
   * Temperature control buttons press: disabled
   * Start button press: disabled
   * Stop button press: disabled
   * Emergency button press: active
   * Pressure switch: active emergency state

> [!NOTE]
> 1. Excluding the emergency stop operation, you cannot press more than one button at a time.

## 2.0 Safety Operations

### 2.1 Emergency Stop

> [!CAUTION]
>  Pressing the Emergency Stop button will cease all function on the board, play the emergency siren, and disable all interactions with the controller by enabling the ***emergency stop mode.***
  - This means that all buttons individual functionality will be disabled.
    
**To EXIT emergency stop mode*** and resume normal function, you must press the black button and the red button at the same time.

### 2.2 Pressure Switch

>[!IMPORTANT]
> We just put the pin in the thing and it will do something.
> (maybe put image here of activating the pressure switch?)



> do we need the below sections? As it will be explained in the top part under scope

## 3.0 Getting Started

> [!IMPORTANT]
> unfinished
Power source USB
System will be powered on immediately.

### 3.1 Temperature Control

> [!IMPORTANT]
> unfinished

### 3.3 Start Heating / Setpoint

>[!IMPORTANT]
>unfinished

### 3.4 Stop Heating

>[!IMPORTANT]
>unfinished


### Black button:
- emergency stop



