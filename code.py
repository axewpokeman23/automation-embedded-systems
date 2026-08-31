from waveshare import PLC
import time

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
while True:
    if not E_STOP and IO.IX0.value:
        print("RUN")
        RUN_STATE = True
        IO.QX0.value = not IO.QX0.value

"""


