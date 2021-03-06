#!/usr/bin/env bash

dir=`dirname $0`

## LAST_PROFILE is set to the last created gnome-therminal profile
LAST_PROFILE=`gconftool-2 -R /apps/gnome-terminal/profiles | grep Profile | \
    awk 'BEGIN { FS = "/" } ; { print $5 }' | sed -e 's/://g' | sort | tail -n 1`

PROFILE=${1:-${LAST_PROFILE}}

# set palette
gconftool-2 -s -t string /apps/gnome-terminal/profiles/$PROFILE/palette `cat $dir/colors/palette`

# set highlighted color to be different from foreground-color
gconftool-2 -s -t bool /apps/gnome-terminal/profiles/$PROFILE/bold_color_same_as_fg false

# set foreground to base00 and background to base3 and highlight color to
# base01
gconftool-2 -s -t string /apps/gnome-terminal/profiles/$PROFILE/background_color `cat $dir/colors/base3`
gconftool-2 -s -t string /apps/gnome-terminal/profiles/$PROFILE/foreground_color `cat $dir/colors/base00`
gconftool-2 -s -t string /apps/gnome-terminal/profiles/$PROFILE/bold_color `cat $dir/colors/base01`

# make sure the profile is set to not use theme colors
gconftool-2 -s -t bool /apps/gnome-terminal/profiles/$PROFILE/use_theme_colors false
