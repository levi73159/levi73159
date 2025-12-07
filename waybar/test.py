#!/usr/bin/env python3

import sys, json
import threading

output = {"text": "hello, world",
                  "class": "custom-" + "spotify",
                  "alt": "spotify"}

def main_loop(): 
    while True:
        sys.stdout.write(json.dumps(output) + "\n")
        sys.stdout.flush()

thread = threading.Thread(target=main_loop)
thread.start();