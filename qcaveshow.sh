#!/bin/bash

# Print only limited version info from cave show
cave show $1 | grep $1 -A4 -m1 
