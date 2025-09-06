#!/bin/bash
# Save as ~/.config/hypr/toggle_resolution.sh

MONITOR_TO_CHANGE="DP-3"
MONITOR_TO_KEEP="DP-1"

# Get current resolution of DP-3
CURRENT=$(hyprctl monitors -j | jq -r '.[] | select(.name=="'$MONITOR_TO_CHANGE'") | .width')

if [ "$CURRENT" = "1920" ]; then
    # DP-1: 4K with 1.6 scale, DP-3: 1440p with 1.0 scale
    # DP-1 logical width = 3840/1.6 = 2400, so DP-3 starts at x=2400
    hyprctl keyword monitor "$MONITOR_TO_KEEP,3840x2160@60,0x0,1.60" && \
    hyprctl keyword monitor "$MONITOR_TO_CHANGE,2560x1440@179.96,2400x0,1.00"
    notify-send "Resolution Changed - STANDARD" "DP-3: 2560x1440 @ 179.96Hz" -i video-display -t 3000
else
    # DP-1: 4K with 1.6 scale, DP-3: 1080p with 1.0 scale
    # DP-1 logical width = 3840/1.6 = 2400, so DP-3 starts at x=2400
    hyprctl keyword monitor "$MONITOR_TO_KEEP,3840x2160@60,0x0,1.60" && \
    hyprctl keyword monitor "$MONITOR_TO_CHANGE,1920x1080@119.88,2400x0,1.00"
    notify-send "Resolution Changed - GAMING" "DP-3: 1920x1080 @ 119.88Hz" -i video-display -t 3000
fi
