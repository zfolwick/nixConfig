#! /usr/bin/python3
import sys
import subprocess
import os
import time

# Executes a command, and then tells you that you've completed it.
try:
  sys.argv[1]
except:
  print("Missing arguments! Expecting something to follow \n")

# godo.sh [ --duration | -d ] : says duration
# godo.sh [ --exit-code | -e ] : says exit code
# godo.sh [no-args] : says "done"
allArgs = sys.argv

godoCommand = allArgs.pop(0)

duration = False
exitCode = False
doneMessage = "done."


startTime = time.time()
proc = subprocess.run(' '.join(allArgs), shell=True)

endTime = time.time()
elapsedTime = endTime - startTime

if elapsedTime > 60:
  minutes, seconds = divmod(elapsedTime, 60)
  elapsedTimeString = f"{int(minutes)} minutes and {seconds: .1f} seconds"
else:
  elapsedTimeString = f"{elapsedTime: .1f} seconds"

argument = allArgs.pop(0)
os.system("osascript -e 'display notification \"done with " + argument + "!\" with title \"command compled\"'")

doneMessage += "It took " + elapsedTimeString + " and exit code is " + str(proc.returncode)

os.system("say " + doneMessage)

