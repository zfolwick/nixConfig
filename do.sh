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

allArgs = sys.argv

commandArgs = allArgs.pop(0)

startTime = time.time()
proc = subprocess.run(' '.join(allArgs), shell=True)

endTime = time.time()
elapsedTime = endTime - startTime

if elapsedTime > 60:
  minutes, seconds = divmod(elapsedTime, 60)
  elapsedTimeString = f"{int(minutes)} minutes and {seconds: .1f} seconds"
else:
  elapsedTimeString = f"{elapsedTime: .1f} seconds"

os.system("osascript -e 'display notification \"done with " + allArgs.pop(0) + "!\" with title \"command compled\"'")

os.system("say done, sir. It took " + elapsedTimeString + " and exit code is " + str(proc.returncode))

