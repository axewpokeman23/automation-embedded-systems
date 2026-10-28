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

We will be using the Raspberry Pico W to test the connected hardware (digital, and analogue inputs, and outputs) and to demonstrate that the PLC is functioning as intended.

## 2.0 Hardware and I/O Mapping

The system contains 7 inputs to control the associating 9 outputs.<br>
##### Inputs include:

1. Start / Heating ON / Setpoint
2. Stop / Heating OFF
3. Temperature Up
4. Temperature Down
5. Emergency Stop
6. Pressure Switch
7. Thermister(Temperature simulated with dial)

##### Outputs include:

1. Heater LED
2. Temperature Range Indicators (Relays / LED0-5)
3. Emergency LED
4. Servo(Water valve)

picture of board and inputs 

Jump to [Variable documentation](#variables)

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

The following table contains evidence that each operation works as intended. Modbus and Runtime were also used to confirm that the inputs, coils, input registers and holding registers were working correctly.

|Test|Expected Result|Pass/Fail|Evidence|
|-|-|-|-|
|Blue button|Setpoint increases| Works! | |
|Yellow button|Setpoint decreases| Works! | |
|Green button|Activates RUN_STATE| Works! | |
|Red button|Activates STOPPED_STATE| Works! | |
|Black button|Activates EMERGENCY_STATE<br>Black and Red button to disable EMERGENCY_STATE| Works! | |
|DuPont (Pressure Switch)|Activates EMERGENCY_STATE| Works!| |
|Temperature dial|Simulate temperature changes| Works! | |
|Servo|Opens/closes correctly| Works! | |
|PID Control|Controls/stabilises the temperature| Works! | |
|Modbus|Displays inputs, coils, holding registers and input registers| Works! | |
|Runtime|Displays | Works! | |

### 5.0 OpenPLC explanations:

For this assignment, as explained in the [introduction](#10-introduction), we had to replicate our circuitpython code of the previous assignment using the tool OpenPLC in any one of the languages LD or FBD on the pico PLC.

#### 5.1 Variables

Below are the variables we specified on OpenPLC:

![alt text](media/openplc-variables1.png)
![alt text](media/openplc-variables2.png)

<!-- markdown table code was generated by copilot ai 

Can you please convert these screenshots of a table into markdown format? they MUST be 1:1 in the data that they contain.

-->

| # | Name | Class | Type | Location | Initial Value | Implementation | Documentation |
|---|---|---|---|---|---|---|---|
| 1 | STOPPED_STATE | Local | BOOL | | | [STOPPED_STATE Screenshot](#511---stopped-state) | specifies if the device is currently stopped. |
| 2 | RUN_STATE | Local | BOOL | | | [RUN_STATE Screenshot](#512---run-state) | specifies if device is currently running |
| 3 | E_STATE | Local | BOOL | | | [E_STATE Screenshot](#513---e-state) | emergency stop state |
| 4 | START_BTN | Local | BOOL | %IX0.0 | | [START_BTN Screenshot](#514---start-btn) | activates run_state |
| 5 | STOP_BTN | Local | BOOL | %IX0.1 | | [STOP_BTN Screenshot](#515---stop-btn) | deactivates run_state and activates stopped state. |
| 6 | E_STOP | Local | BOOL | %IX0.2 | | [E_STOP Screenshot](#516---e-stop) | activates emergency_stop which totally deactivates all functionality |
| 7 | TEMP_UP | Local | BOOL | %IX0.3 | | [TEMP_UP Screenshot](#517---temp-up) | increases temperature setpoint |
| 8 | TEMP_DWN | Local | BOOL | %IX0.4 | | [TEMP_DWN Screenshot](#518---temp-dwn) | decreases temperature setpoint |
| 9 | P_SWITCH | Local | BOOL | %IX0.5 | | [P_SWITCH Screenshot](#519---p-switch) | enables or disables power output control |
| 10 | HEATER | Local | BOOL | %QX0.0 | | [HEATER Screenshot](#5110---heater) | controlstus indicator LED |
| 14 | LED3 | Local | BOOL | %QX0.4 | | [LED](#5114---led3) | status indicator LED |
| 15 | LED4 | Local | BOOL | %QX0.5 | | #5115---led4 | status indicator LED |
| 16 | LED5 | Local | BOOL | %QX0.6 | | #5116---led5 | status indicator LED |
| 17 | E_LED | Local | BOOL | %QX0.7 | | #5117---e-led | emergency stop indicator LED |
| 18 | SETPOINT | Local | INT | %MW0 | 80 | #5118---setpoint | Default temperature. Min = 80C. Address 32 |
| 19 | POWER | Local | REAL | %MD0 | | #5119---power | Represents heating power output |
| 20 | ACTUAL_TEMPERATURE | Local | INT | %MW1 | | #5120---actual-temperature | current measured temperature |
| 21 | DIAL_VALUE | Local | INT | %IW0 | | #5121---dial-value | Temp dial = simulates actual temperature |
| 22 | SR0 | Local | SR | | | #5122---sr0 | set-reset flip-flop |
| 23 | R_TRIG0 | Local | R_TRIG | | | #5123---r-trig0 | rising edge detector |
| 24 | R_TRIG1 | Local | R_TRIG | | | #5124---r-trig1 | rising edge detector |
| 25 | CTUD0 | Local | CTUD | | | #5125---ctud0 | up/down counter |
| 26 | PWM_CONTROLLER0 | Local | PWM_CONTROLLER | | | #5126---pwm-controller0 | generates PWM output signal |
| 27 | SERVO_OK | Local | BOOL | | | #5127---servo-ok | indicates servo position has been reached |
| 28 | ANGLE | Local | INT | %QW0.1 | 0 | #5128---angle | to test update the servo angle 37 |
| 29 | DUTY | Local | REAL | | | #5129---duty | detects when wave has passed |
| 30 | DIAL_VOLTAGE | Local | REAL | | | #5130---dial-voltage | actual power usage value |
| 31 | R_TRIG2 | Local | R_TRIG | | | #5131---r-trig2 | rising edge detector |
| 32 | PID0 | Local | PID | | | #5132---pid0 | PID control block |


#### OpenPLC code screenshots

##### 5.1.1 - Line 1: STOP-BTN

STOPPED-STATE

![stopped state](media/openplc-code-stoppedstate.png)

`not RUN_STATE and not E_STATE = STOPPED_STATE`

##### 5.1.2 - Line 2: START-BTN or RUN-STATE

![run state](media/openplc-code-runstate.png)

`not STOP-BTN and  START-BTN or RUN-STATE`

STOP_BTN negated to become TRUE when pressed, stopping/breaking the RUN_STATE logic.

##### 5.1.3 - Line 3: E-STOP

![e state](media/openplc-code-estate.png)

##### 5.1.10 - Line 4: HEATER

Code for heater toggling, which dictates what conditions the heater will be allowed to start in:

![heater](media/openplc-code-heater.png)

1. Run state must be on
2. Emergency state must be off
3. Actual temperature is within 10 degrees of the setpoint

##### 5.1.11 - Line 5: TEMPUP and TEMPDOWN

Code for setpoint increase and decrease via the TEMPUP and TEMPDWN buttons.

![setpoint control](media/openplc-code-tempup-tempdown.png)

> included is code for disabling both the LEDs and temperature control if emergency state is currently active

##### 5.1.12 - Line 6: LED0 ->  LED5

Code for LEDs that evaluates the setpoint to activate an LED, where every even number will only activate one LED and every odd number will activate BOTH the previous LED and the next... and so forth.

![led code](media/openplc-code-led.png)

##### 5.1.20 - Line 7: ACTUAL_TEMPERATURE

Code for calculating the actual temperature from normalizing the values output from the potentiometer into the 0-190 range.

![actual temperature](media/openplc-code-actualtemperature.png)

Jump to [Modbus](#52---modbus) to see proof that the temperature conversion works.


##### 5.1.26 - Line 8: PWM-CONTROLLER

Automatically controls the servo, where `CHANNEL` tells the controller where the servo is, and `DUTY` the angle the servo should currently sit at.

![pwm controller0](media/openplc-code-pwmcontroller0.png)


##### 5.1.29 - Line 9: DUTY

Calculates which direction to push the servo/pressure valve according to the temperature. 

![duty](media/openplc-code-duty.png)

##### 5.1.30 - Line 10: dial_voltage

Calculates the power usage by multiplying dial value by the max power value, and then dividing by the max memory address storage size for INT type values.

![dial voltage](media/openplc-code-dialvoltage.png)


##### 5.1.32 - Line 11: PID0

PID implemented similar to our previous assignment.

![pid0](media/openplc-code-pid0.png)

#### 5.2 - MODBUS



#### 5.3 - Runtime


### 6 - Troubles we face 
<!--
notes:
connected by SERIAL COM11

OpenPLC logic and code explanations:




-->
