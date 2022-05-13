#!/bin/bash

if dunstctl is-paused | grep -q "false" ;
then
    status=""
    class="disabled"
else
    status=" $(dunstctl count waiting)"
    class="activated"
fi

echo -e "{\"class\":\"$class\",\"text\":\"$status\"}"
