#!/bin/bash

# Get mako history
HISTORY=$(makoctl history 2>/dev/null)

# Check if makoctl command failed
if [ $? -ne 0 ]; then
    notify-send "Notifications" "Cannot access notification history" -t 3000
    exit 1
fi

# Parse notifications from history
NOTIFICATIONS=""
COUNT=0

# Extract notification summaries using a safer method
if echo "$HISTORY" | jq empty 2>/dev/null; then
    # JSON is valid, try to parse it
    while IFS= read -r summary; do
        if [ -n "$summary" ] && [ "$summary" != "null" ]; then
            COUNT=$((COUNT + 1))
            NOTIFICATIONS="${NOTIFICATIONS}${COUNT}. ${summary}\n"
            if [ $COUNT -ge 5 ]; then
                break
            fi
        fi
    done < <(echo "$HISTORY" | jq -r '.data[0][]?.summary.data // empty' 2>/dev/null)
fi

# Show results
if [ $COUNT -eq 0 ]; then
    notify-send "Notifications" "No recent notifications found" -t 3000
else
    printf -v DISPLAY_TEXT "$NOTIFICATIONS"
    notify-send "Recent Notifications" "$DISPLAY_TEXT" -t 8000
fi
