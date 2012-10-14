#!/usr/bin/python

import dbus
import time
#import os
import signal, sys

if len(sys.argv) != 3 :
  sys.stderr.write('Usage: pm-inhibit.py <appname> <reason>\n')
  sys.exit(1)

def sighandler(signum, frame) :
        dev.UnInhibit(cookie)
        exit()

bus = dbus.Bus(dbus.Bus.TYPE_SESSION)
devobj = bus.get_object('org.freedesktop.PowerManagement', '/org/freedesktop/PowerManagement/Inhibit')
dev = dbus.Interface (devobj, "org.freedesktop.PowerManagement.Inhibit")
cookie = dev.Inhibit(sys.argv[1], sys.argv[2])

# going away from dbus when dieing should be enough, but be sure 
signal.signal(signal.SIGTERM, sighandler)
print cookie

while 1 == 1 :
        time.sleep(30)
