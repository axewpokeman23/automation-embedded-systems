"""
    task list:
        - allow this to be used with the GUI
        - temperature control : update external value that will go to the GUI to show the temperature
        
        - ERROR checking : check every way which the code could be broken
            - should NOT be able to spam the buttons
            
        - start : starts heating according to temperature set by the blue and yellow buttons
            - temperature cannot be changed while the heating is on
            
        - stop : stops heating, and allows the temperature to be changed
        
        - use the temperature decrease and increase function inside the actual buttons
            - maybe also turn the "if not button" lines into functions? - optional
            
        - holding the button down = passive temperature change while button is down
        
        - temperate going below zero for some reason when decrease_temp is ran (and also during the emergency stop temperature reset)
"""

from waveshare import PLC
import time
import simpleio

# initialise
print (" ---------------------------- Starting...")
IO = PLC()
IO.init_all()
#time.sleep(0.01)

# states
#STOPPED_STATE = 0
#RUN_STATE = 1
#E_STOP = 2
# default state
#state = STOPPED_STATE

COUNT = 0

# switches
E_STOP_SWITCH = False # for emergency stop
STOPPED_STATE = True # used to be RUN_STATE = False. stopped by default
HEATING = False # heating switch


# led colours - GRB
#OFF = IO.RGB_LED.fill(())
GREEN = [255,0,0]
RED = [0,255,0]
BLACK = [0, 255, 255] # purple
BLUE = [0,0,255]
YELLOW = [255,170,0]

RAINBOW = [RED, YELLOW, GREEN, BLUE, BLACK]

# Temperature control
temp = 80 # default temp
LOWEST_TEMP = 80
EMERGENCY_TEMP = 180 # temperate functionally CANNOT go above this

# functions
def change_LED(colour:list):
    IO.RGB_LED.fill(colour)
    
# temperature control
def increase_temp():
    global temp
    temp += 10
    time.sleep(0.3)
    print(temp)
    
def decrease_temp():
    global temp
    temp -= 10
    time.sleep(0.3)
    print(temp)

while True:
    # inputs
    START_BTN = IO.IX0.value
    STOP_BTN = IO.IX1.value
    E_STOP = IO.IX2.value
    UP_BTN = IO.IX3.value
    DOWN_BTN = IO.IX4.value
    
    
    # when you press the green button:
    if not START_BTN:
        time.sleep(0.2)
        print("green")
        change_LED(GREEN)
        if STOPPED_STATE:
            # output :
            #IO.QX0.value = not IO.QX0.value
            #IO.QX1.value = not IO.QX0.value
        
            # rainbow LED!!!
            """
            while STOP_BTN:
                    for colour in RAINBOW:
                        time.sleep(1)
                        change_LED(colour)
            """
            print("powered on" if not E_STOP_SWITCH else "emergency stop disabled - powered on")
            
            E_STOP_SWITCH = False
            STOPPED_STATE = False
        
        
        else: # if person presses the button again and "STOPPED_STATE" is False (currently on), then 
            # assume person wants the heating to start
            if temp < EMERGENCY_TEMP:
                print("heating start - temperature control disabled")
                HEATING = True
        
    # allow the other buttons to be pressed ONLY if ESTOP is FALSE and runstate is active
    if not E_STOP_SWITCH and not STOPPED_STATE:
        if not STOP_BTN:
            """test code
            time.sleep(0.2)
            print("red")
            change_LED(RED)
            """
            time.sleep(0.2)
            #print("red")
            
            # just to check temperature
            print(temp)
            
            # heating is switched off and temperature changing can work
            HEATING = False
            print("heating has been switched off - temperature control enabled")
            
            #change_LED(RED)
    
        if not E_STOP: #emergency stop
            """test
            time.sleep(0.2)
            print("black")
            change_LED(BLACK)
            """
            time.sleep(0.2)
            #print("black")
            change_LED(BLACK)
            
            
            while temp != LOWEST_TEMP:
                # to simulate it going down progressively
                time.sleep(0.1)
                decrease_temp()
                # to show the temperature going down in a cool way
                print(temp)
                
            
            # if you press emergency stop everything will stop working
            E_STOP_SWITCH = True
            STOPPED_STATE = True
            #RUN_STATE = False
            
            
            
            
            
        # as long as the temperature is below 180 and above 0 you can press the blue and yellow buttons
        if temp < EMERGENCY_TEMP and temp >= LOWEST_TEMP and not HEATING:
            
            if not UP_BTN and DOWN_BTN: # "and DOWNBTN": to stop people from pressing both buttons at the same time
                """test
                time.sleep(0.2)
                print("blue")
                change_LED(BLUE)
                """
                time.sleep(0.2)
                #print("blue")
                change_LED(BLUE)
                increase_temp()
                
        
            if not DOWN_BTN and UP_BTN: # "and UPBTN": to stop people from pressing both buttons at the same time
                """test
                time.sleep(0.2)
                print("yellow")
                change_LED(YELLOW)
                """
                time.sleep(0.2)
                #print("yellow")
                change_LED(YELLOW)
                
                # update temperature
                decrease_temp()
        elif not DOWN_BTN or not UP_BTN and not HEATING:
            
            if temp >= EMERGENCY_TEMP:
                if not UP_BTN:
                    time.sleep(1)
                    print(f'{temp}: cannot go above this temperature! Heating has been switched off automatically.')
                elif not DOWN_BTN:
                    decrease_temp()
                
            elif temp <= LOWEST_TEMP:
                if not DOWN_BTN:
                    time.sleep(1)
                    print(f'{temp}: cannot go below this temperature.')
                elif not UP_BTN:
                    increase_temp()
    #time.sleep(0.01)
    IO.RGB_LED.show()
