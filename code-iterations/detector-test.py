"""
output in increments of 10

"""

counter = 0
SETPOINT = 180

for y in range(10):
    for x in range(SETPOINT):


    # go up 1 every 10 rounds until 180
        counter += y

print(counter)
