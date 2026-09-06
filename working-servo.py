# WATER BOILER PROJECT
# BY MARAEA AND SARA

from waveshare import PLC
import time
import simpleio

# initialise
IO = PLC()
IO.init_all()
IO.setServo()
# default angle of the servo
IO.SERVO.angle = 0
print("\n--------------------------------\nWaterBoiler3000 has powered on.\n--------------------------------\n\nINSTRUCTIONS:\nPlease select a temperature using the BLUE button for UP and the YELLOW button for DOWN.\nPress the GREEN button to start heating and the RED button to stop heating.\n\nIMPORTANT:\nIn case of an EMERGENCY, press the BLACK button to enable the EMERGENCY STOP.\nTo disable the EMERGENCY STOP, press the BLACK and RED button simultaneously.\n")

#-----STATE-MACHINE-----#

# states
STOPPED_STATE = 0
RUN_STATE = 1
EMERGENCY_STATE = 2

# default state
state = STOPPED_STATE

#------TEMPERATURE------#

# default temperature = 80C
ACTUAL_TEMPERATURE = 0
SETPOINT = 80
MIN_TEMP = 80
MAX_TEMP = 180
# default LED = 80C
IO.QX1.value = True

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
        
        # rainbow
        time.sleep(0.1)
        LED_colour(colour)
    x+=1

#---------NOTES---------#

#simpleio.tone(IO.BUZZER,261,0.25)

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
    "F5": 698.46
}

SONG = [("C4",0.2),
        ("G4",0.2),
        ("C5",0.25)]


def play_sound(note:str,duration:float):
    #tone = NOTES.get(note)
    #simpleio.tone(IO.BUZZER,tone,duration)
    return

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
	return (v-x) / (y-x) * (b-a) + a


for x in range(1):
    for note, duration in SONG:
        # ringtone
        play_sound(note,duration)

#---------LATCH--------#
latch = False
emergency_latch = False

# loop
while True:

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
    #47 servo
    #DH11

    # STOPPED (DEFAULT STATE)
    if state == STOPPED_STATE:
        LED_colour(BLACK)
        HEATER.value = False
        E_LED.value = False
            
        #(BLUE BUTTON)
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
            LED_colour(BLUE)
            time.sleep(0.2)
            
            
        #(YELLOW BUTTON)
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
            LED_colour(BLUE)
            time.sleep(0.2)
            
            
        # (GREEN BUTTON)
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
            print(f"\nTarget temperature: {SETPOINT}°C.\nHeating started...")
            
    # RUNNING = heating in progress
    elif state == RUN_STATE:
        
        # control valve stuff
        v = (IO.IW0.value * 3.3) / 65536
        t = mapto(v,0.0, 3.3, 80, 180)
        a = mapto(t, 80, 180, 0, 180)
        IO.SERVO.angle = int(a)
        time.sleep(1)
        print(f"Current temperature = {t:0.2f}")
             
        
        LED_colour(GREEN)
        HEATER.value = True
        
            
        # (RED BUTTON)
        # STOP_BTN pressed, heating process stops and enables temperature controls
        if (STOP_BTN
            and not START_BTN
            and not E_STOP
            and not TEMP_UP_BTN
            and not TEMP_DOWN_BTN):
            state = STOPPED_STATE
            latch = False
            print("\nHeating stopped...")
            
        # (BLACK BUTTON)
        # E_STOP pressed while in RUN_STATE, switches to EMERGENCY_STATE
        if E_STOP or P_STOP:
            emergency_latch = True
            state = EMERGENCY_STATE
            print("\nEMERGENCY ALERT!")
            
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
        # E_STOP and STOP_BTN press disables EMERGENCY_STATE, unlatching the E_STOP and switches to STOPPED_STATE (default state)
        if (E_STOP
        and not START_BTN
        and STOP_BTN
        and not TEMP_UP_BTN
        and not TEMP_DOWN_BTN):
            emergency_latch = False
            latch = False
            state = STOPPED_STATE
            SETPOINT = 80
            print("End of emergency")
            E_LED.value = False
            LED1.value = True
            
    IO.RGB_LED.show()
    #IO.setServo()
