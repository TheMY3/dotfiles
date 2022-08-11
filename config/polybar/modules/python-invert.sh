#!/bin/bash

# This bash script (1) runs a python script if not already running
# or (2) kills the script if already running. Easily put, it inverts
# the running state of the script. Great for toggling GUI scripts.

# Run chmod +x python-invert.sh and then run this with the python
# script path as parameter: ./python-invert.sh path/to/script.py

script_name=${1}
if pgrep -f "python $script_name" &>/dev/null; then
	pkill -f $script_name
else
	python $script_name
fi
