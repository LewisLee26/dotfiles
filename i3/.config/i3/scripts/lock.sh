#!/bin/bash

# Clean up previous screenshot
[ -f "/tmp/screen\_locked.png" \] && rm -f /tmp/screen\_locked.png

# Take a screenshot
scrot /tmp/screen\_locked.png

# Pixellate it 10x
mogrify -scale 10% -scale 1000% /tmp/screen\_locked.png

# Lock screen displaying this image.
i3lock -i /tmp/screen\_locked.png

# Turn the screen off after a delay.
sleep 60; pgrep i3lock && xset dpms force off
