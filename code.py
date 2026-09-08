#code.py
# WATER BOILER PROJECT
# BY MARAEA AND SARA

from waveshare import PLC
import time
import simpleio
from lib.simple_pid import PID

#-----INITIALISATION-----#

IO = PLC()
IO.init_all()
IO.setServo()
# default angle of the servo
IO.SERVO.angle = 0
start_time = time.monotonic()
print("""
--------------------------------
WaterBoiler3000 has powered on.
--------------------------------

INSTRUCTIONS:
Please select a temperature using the BLUE button for UP and the YELLOW button for DOWN.
Press the GREEN button to start heating and the RED button to stop heating.

IMPORTANT:
In case of an EMERGENCY, press the BLACK button to enable the EMERGENCY STOP.
To disable the EMERGENCY STOP, press the BLACK and RED button simultaneously.
""")

#---------STATE---------#

STOPPED_STATE = 0
RUN_STATE = 1
EMERGENCY_STATE = 2

# default state
state = STOPPED_STATE

#------TEMPERATURE------#

# default setpoint temperature = 80C
SETPOINT = 80
MIN_TEMP = 80
MAX_TEMP = 180
IO.QX1.value = True
# default water temp
ACTUAL_TEMPERATURE = 20
power = 0
# water valve
WATER_VALVE_CLOSED = 0

#--------COLOURS--------#

# LED colours (GRB)
BLACK = [0,0,0]     # STOPPED_STATE / STOP_BTN
GREEN = [255,0,0]    # RUN_STATE / START_BTN
RED = [0,255,0]      # EMERGENCY_STATE / E_STOP
YELLOW = [234,255,0] # PRESSURE_SWITCH
BLUE = [0,0,80]      # TEMP CHANGE INDICATION
PURPLE = [0, 255, 255] # purple

def LED_colour(colour:list):
    IO.RGB_LED.fill(colour)

RAINBOW = [RED, YELLOW, GREEN, BLUE, PURPLE]

# rainbow LED - upon initialization
for x in range(1):
    for colour in RAINBOW:
        time.sleep(0.1)
        LED_colour(colour)
    x+=1

#---------NOTES---------#

NOTES = {
    "C4": 261.63,
    "D4": 293.66,
    "E4": 329.63,
    "F4": 349.23,
    "G4": 392,
    "A4": 440,
    "B4": 493.88,
    "C5": 523.25,
    "D5": 587.33,
    "E5": 659.25,
    "F5": 698.46 }

SONG = [("C4",0.2),
        ("G4",0.2),
        ("C5",0.25)]

# currently disabled
def play_sound(note:str,duration:float):
    tone = NOTES.get(note)
    simpleio.tone(IO.BUZZER,tone,duration)
    return

# power on ringtone
for x in range(1):
    for note, duration in SONG:
        play_sound(note,duration)

#----TEMPERATURE-DIAL----#
    """
    v = input value: current voltage
    
    input range:
    x = min volt
    y = max volt
    
    output range:
    a = min temp
    b = max temp
    """
def mapto(v, x, y, a, b):
    #moves valve with the dial
    return (v-x) / (y-x) * (b-a) + a

    """
    def pressure_valve(angle):
    # update and move servo angle / pressure valve
        try:
            IO.SERVO.angle = int(angle)
        except:
            print(f"error with angle {angle} = must be within 80-180")
    """
    
#def range_check(temp=0, setpoint=80, r=2):
    #return (setpoint - (r + 1)) <= temp < (setpoint + r)
    #returns true or false if value is within a specified range
    """
    if diff < r and diff >= 0:#temp in range(setpoint - r, setpoint                + (r + 1)):
        print("diff:" , diff)
        return True
    
    # if the temperature is below zero... 
    elif diff <= 0 and (temp + diff) in range((setpoint - r), (setpoint + r)):
        print("diff:", diff)
        return True
    """

#---------LATCH--------#

latch = False
emergency_latch = False

#---------PID----------#

pid = PID(2, 0.001, 0.0, setpoint=SETPOINT)
pid.output_limits = (0, 100)

#------SUPER-LOOP------#

count = 0
while True:
    count+=1

#---------GPIO---------#

    # inputs
    START_BTN = not IO.IX0.value
    STOP_BTN = not IO.IX1.value
    E_STOP = not IO.IX2.value
    TEMP_UP_BTN = not IO.IX3.value
    TEMP_DOWN_BTN = not IO.IX4.value
    P_STOP = not IO.IX5.value

    # outputs
    HEATER = IO.QX0
    LED1 = IO.QX1
    LED2 = IO.QX2
    LED3 = IO.QX3
    LED4 = IO.QX4
    LED5 = IO.QX5
    LED6 = IO.QX6
    E_LED = IO.QX7


# STOPPED (DEFAULT STATE)
    if state == STOPPED_STATE:
        LED_colour(BLACK)
        HEATER.value = False
        E_LED.value = False
        IO.SERVO.angle = WATER_VALVE_CLOSED


        # TEMPERATURE UP(BLUE BUTTON)
        # TEMP_UP_BTN counts temp up (MAX: 180C)
        if (TEMP_UP_BTN
            and not START_BTN
            and not STOP_BTN
            and not E_STOP
            and not TEMP_DOWN_BTN):
            if (SETPOINT < MAX_TEMP):
                SETPOINT += 10
                play_sound("C5",0.2)
                print(f"Temperature set to {SETPOINT}°C.")
                LED1.value = False
                LED2.value = False
                LED3.value = False
                LED4.value = False
                LED5.value = False
                LED6.value = False
                # LED1, LED2
                if SETPOINT == 90:
                    LED1.value = True
                    LED2.value = True
                # LED2
                elif SETPOINT == 100:
                    LED2.value = True
                # LED2, LED3
                elif SETPOINT == 110:
                    LED2.value = True
                    LED3.value = True
                # LED3
                elif SETPOINT == 120:
                    LED3.value = True
                # LED3, LED4
                elif SETPOINT == 130:
                    LED3.value = True
                    LED4.value = True
                # LED4
                elif SETPOINT == 140:
                    LED4.value = True
                # LED4, LED5
                elif SETPOINT == 150:
                    LED4.value = True
                    LED5.value = True
                # LED5
                elif SETPOINT == 160:
                    LED5.value = True
                # LED5, LED6
                elif SETPOINT == 170:
                    LED5.value = True
                    LED6.value = True
                # LED6
                elif SETPOINT == 180:
                    LED6.value = True
            # MAX_TEMP REACHED
            else:
                play_sound("F5",0.2)
                play_sound("C4",0.2)
                print("Error: Maximum setpoint of 180°C has been reached.\n")
            LED_colour(BLUE)
            time.sleep(0.2)


        # TEMPERATURE DOWN (YELLOW BUTTON)
        # TEMP_DOWN_BTN counts temp down (MIN: 80C)
        if (TEMP_DOWN_BTN
            and not START_BTN
            and not STOP_BTN
            and not E_STOP
            and not TEMP_UP_BTN):
            if (SETPOINT > MIN_TEMP):
                SETPOINT -= 10
                play_sound("B4",0.2)
                print(f"Temperate set to {SETPOINT}°C.")
                # LEDs OFF
                LED1.value = False
                LED2.value = False
                LED3.value = False
                LED4.value = False
                LED5.value = False
                LED6.value = False
                # LED6
                if SETPOINT == 180:
                    LED6.value = True
                # LED5, LED6
                elif SETPOINT == 170:
                    LED6.value = True
                    LED5.value = True
                # LED5
                elif SETPOINT == 160:
                    LED5.value = True
                # LED4, LED5
                elif SETPOINT == 150:
                    LED5.value = True
                    LED4.value = True
                # LED4
                elif SETPOINT == 140:
                    LED4.value = True
                # LED3, LED4
                elif SETPOINT == 130:
                    LED4.value = True
                    LED3.value = True
                # LED3
                elif SETPOINT == 120:
                    LED3.value = True
                # LED2, LED3
                elif SETPOINT == 110:
                    LED3.value = True
                    LED2.value = True
                # LED2
                elif SETPOINT == 100:
                    LED2.value = True
                # LED1, LED2
                elif SETPOINT == 90:
                    LED2.value = True
                    LED1.value = True
                # LED1
                elif SETPOINT == 80:
                    LED1.value = True
            # MIN_TEMP REACHED
            else:
                play_sound("F5",0.2)
                play_sound("C4",0.2)
                print("\nError: Minimum setpoint of 80°C has been reached.\n")
            LED_colour(BLUE)
            time.sleep(0.2)


        # START HEATING / SETPOINT (GREEN BUTTON)
        # START_BTN pressed, sets target temperature, disabling temperature controls and starts heating process
        if (START_BTN
            and not STOP_BTN
            and not E_STOP
            and not TEMP_UP_BTN
            and not TEMP_DOWN_BTN
            and not latch):
            E_LED.value = False
            latch = True
            state = RUN_STATE
            #PID
            pid.setpoint = SETPOINT
            pid.reset()
            print(f"\nTarget temperature: {SETPOINT}°C.\nHeating started...")


# RUNNING STATE = heating in progress
    elif state == RUN_STATE:
        if count % 100 == 0:
            # read temperature
            value = (IO.IW0.value * 3.3) / 65536
            # min = room temp (20C), max = 185C
            ACTUAL_TEMPERATURE = mapto(value,0.0, 3.3, 20, 185)
            # update servo
            # servo controls simulated water valve
            # valve opens progressively as temp increases
            servo_angle = mapto (ACTUAL_TEMPERATURE, 20, 185, 15, 180)
            IO.SERVO.angle = int(servo_angle)
            
            # PID
            error = SETPOINT - ACTUAL_TEMPERATURE
            power = pid(ACTUAL_TEMPERATURE)
            
            # TIME
            elapsed_time = time.monotonic() - start_time

            #if int(ACTUAL_TEMPERATURE) in range(80, 180):
                # if temp is in range 80 - 180, allow servo to move (to fix the angle issue)
                
                # servo = water valve : 0 = closed 180 = fully open
                #servo_angle = mapto(ACTUAL_TEMPERATURE, 80, 180, 0, 180)
                #try:
                    #IO.SERVO.angle = int(servo_angle)
                #except:
                    #print(f"error with angle {servo_angle} = must be within 80-180")
            
            #in_range = range_check(ACTUAL_TEMPERATURE, SETPOINT)
            
            # checks: temp above setpoint,
            # if the setpoint and actual temperature are "synchronized":

            # BANG BANG CONTROL
            if (ACTUAL_TEMPERATURE >= SETPOINT+2): #or (in_range and int(ACTUAL_TEMPERATURE)):
                HEATER.value = False
                LED_colour(BLACK)
                # checks: if temp less than setpoint, and
                # if temp is below 80... heating is turned on
            elif ACTUAL_TEMPERATURE <= SETPOINT-2:
                HEATER.value = True
                LED_colour(GREEN)
            print(f"""
--------------------------------
     HEATING CONTROL STATUS
--------------------------------
Uptime: {elapsed_time:0.02f}s
Temperature setpoint: {SETPOINT}°C
Current temperature: {ACTUAL_TEMPERATURE:0.2f}°C
Temperature error: {error:.02f}°C
Water valve angle: {servo_angle:0.2f}°
PID/heating power output: {power:.02f}%""")


        # STOP HEATING (RED BUTTON)
        # STOP_BTN pressed, heating process stops and enables temperature controls
        if (STOP_BTN
            and not START_BTN
            and not E_STOP
            and not TEMP_UP_BTN
            and not TEMP_DOWN_BTN):
            # PID reset
            pid.reset()
            state = STOPPED_STATE
            latch = False
            print(f"\nHeating stopped...\nWater valve angle: {WATER_VALVE_CLOSED}°")


        # EMERGENCY STOP (BLACK BUTTON)
        # E_STOP pressed while in RUN_STATE, switches to EMERGENCY_STATE
        if E_STOP or P_STOP:
            emergency_latch = True
            # PID reset
            pid.reset()
            state = EMERGENCY_STATE
            IO.SERVO.angle = WATER_VALVE_CLOSED
            print(f"""
--------------------------------
       EMERGENCY ALERT!
--------------------------------

BOILER STATUS:
Heating: Stopped
Water valve angle: {WATER_VALVE_CLOSED}°.

To disable EMERGENCY STOP:
Press the BLACK button and RED button simultaneously.""")


# EMERGENCY STATE disables all processes and buttons
    elif state == EMERGENCY_STATE:
        LED_colour(RED)
        HEATER.value = False
        LED1.value = False
        LED2.value = False
        LED3.value = False
        LED4.value = False
        LED5.value = False
        LED6.value = False
        simpleio.tone(IO.BUZZER,261,0.25)
        E_LED.value = True
        # E_STOP and STOP_BTN press disables EMERGENCY_STATE, unlatching the E_STOP and switches to STOPPED_STATE
        if (E_STOP
        and not START_BTN
        and STOP_BTN
        and not TEMP_UP_BTN
        and not TEMP_DOWN_BTN):
            emergency_latch = False
            latch = False
            state = STOPPED_STATE
            SETPOINT = 80
            print("End of emergency.")
            E_LED.value = False
            LED1.value = True

    IO.RGB_LED.show()
    time.sleep(0.01)