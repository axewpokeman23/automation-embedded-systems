from waveshare import PLC
import time
import simpleio

# initilise
print ("Starting...")
IO = PLC()
IO.init_all()
#time.sleep(0.01)

"""
# states
STOPPED_STATE = 0
RUN_STATE = 1
E_STOP = 2

# default state
state = STOPPED_STATE
"""

COUNT = 0
IO.RGB_LED.fill((0,0,80)) #GRB

while True:
    # inputs
    START_BTN = IO.IX0.value
    STOP_BTN = IO.IX1.value
    E_STOP = IO.IX2.value
    UP_BTN = IO.IX3.value
    DOWN_BTN = IO.IX4.value
    #count
    COUNT += 1
    # START_BTN = IO.IX0 / GI1
    if not START_BTN:
        IO.QX0.value = not IO.QX0.value
        IO.QX1.value = not IO.QX0.value
        IO.RGB_LED.fill((20,20,20)) # GRB
        # update waveshare.py to support the buzzer
        # .tone(port,frequency,length,duration)
        #simpleio.tone(IO.BUZZER,261,0.25)
    # STOP_BTN = IO.IX1/ GI2
    if not STOP_BTN:
        IO.QX0.value = not IO.QX0.value
        IO.QX1.value = not IO.QX1.value
        IO.RGB_LED.fill((0,80,80)) #GRB
        #simpleio.tone(IO.BUZZER,293,0.25)
    # E_STOP = IO.IX2 / GI3
    if not E_STOP:
        IO.RGB_LED.fill((0,250,0)) # GRB
        #simpleio.tone(IO.BUZZER,329,0.25)
        IO.LED.value = not IO.LED.value # no LED on the waveshare board - uses RGB    
    # UP_BTN = IO.IX3 / GI4
    if not UP_BTN:
        IO.QX0.value = not IO.QX0.value
        IO.QX1.value = not IO.QX1.value
        IO.RGB_LED.fill((0,80,80)) #GRB
        #simpleio.tone(IO.BUZZER,349,0.25)
    # DOWN_BTN = IO.IX4 / GI5
    if not DOWN_BTN:
        IO.QX0.value = not IO.QX0.value
        IO.QX1.value = not IO.QX1.value
        IO.RGB_LED.fill((0,80,80)) #GRB
        #simpleio.tone(IO.BUZZER,392,0.25)
    time.sleep(0.01)
    IO.RGB_LED.show()

"""
COUNT = 0
while True:
    COUNT += 1
    if not IO.IX0.value and (COUNT % 40 == 0):
        IO.QX0.value = not IO.QX0.value
        IO.QX1.value = not IO.QX0.value


    if not IO.IX1.value and (COUNT % 20 == 0):
        IO.QX0.value = not IO.QX0.value
        IO.QX1.value = not IO.QX0.value

    time.sleep(0.01)
"""
