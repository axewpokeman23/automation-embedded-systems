from waveshare import PLC
import time
import simpleio

# initialise
IO = PLC()
IO.init_all()
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

#--------COLOURS--------#

# LED colours (GRB)
BLACK = [0,0,0]      # STOPPED_STATE / STOP_BTN
GREEN = [255,0,0]    # RUN_STATE / START_BTN
RED = [0,255,0]      # EMERGENCY_STATE / E_STOP
YELLOW = [234,255,0] # PRESSURE_SWITCH
BLUE = [0,0,80]      # TEMP CHANGE INDICATION

def LED_colour(colour:list):
    IO.RGB_LED.fill(colour)

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

    # outputs
    HEATER = IO.QX0

    # STOPPED (DEFAULT STATE)
    if state == STOPPED_STATE:
        LED_colour(BLACK)
        HEATER.value = False
            
        #(BLUE BUTTON)
        # TEMP_UP_BTN counts temp up (MAX: 180C)
        if (TEMP_UP_BTN
            and not START_BTN
            and not STOP_BTN
            and not E_STOP
            and not TEMP_DOWN_BTN
            and SETPOINT < MAX_TEMP):
            SETPOINT += 10
            LED_colour(BLUE)
            print(f"Temperature set to {SETPOINT}°C.")
            time.sleep(0.2)
            
        #(YELLOW BUTTON)
        # TEMP_DOWN_BTN counts temp down (MIN: 80C)
        if (TEMP_DOWN_BTN
            and not START_BTN
            and not STOP_BTN
            and not E_STOP
            and not TEMP_UP_BTN
            and SETPOINT > MIN_TEMP):
            SETPOINT -= 10
            LED_colour(BLUE)
            print(f"Temperate set to {SETPOINT}°C.")
            time.sleep(0.2)
            
        # (GREEN BUTTON)
        # START_BTN pressed, sets target temperature, disabling temperature controls and starts heating process
        if (START_BTN
            and not STOP_BTN
            and not E_STOP
            and not TEMP_UP_BTN
            and not TEMP_DOWN_BTN
            and not latch):
            latch = True
            state = RUN_STATE
            print(f"\nTarget temperature: {SETPOINT}°C.\nHeating started...")
            
    # RUNNING = heating in progress
    elif state == RUN_STATE:
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
        if E_STOP:
            emergency_latch = True
            state = EMERGENCY_STATE
            print("\nEMERGENCY ALERT!")
            
    # EMERGENCY STATE disables all processes and buttons
    elif state == EMERGENCY_STATE:
        LED_colour(RED)
        HEATER.value = False
            
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
            #simpleio.tone(IO.BUZZER,261,0.25)
            
    time.sleep(0.2)
    IO.RGB_LED.show()
