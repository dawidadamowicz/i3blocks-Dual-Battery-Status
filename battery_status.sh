#!/bin/bash

BATTERY_PATHS=("/sys/class/power_supply/BAT0" "/sys/class/power_supply/BAT1")
TOTAL_CAPACITY=0
TOTAL_PERCENT=0
STATUS="Discharging"
CHARGING_ICON="⚡"
LOW_BATTERY_ICON="🔋"

for BATTERY_PATH in "${BATTERY_PATHS[@]}"; do
    if [ -d "$BATTERY_PATH" ] && [ -f "$BATTERY_PATH/capacity" ]; then
        CAPACITY=$(cat "$BATTERY_PATH/capacity")
        BATTERY_STATUS=$(cat "$BATTERY_PATH/status")
        
        TOTAL_CAPACITY=$((TOTAL_CAPACITY + 1))
        TOTAL_PERCENT=$((TOTAL_PERCENT + CAPACITY))
        
        if [ "$BATTERY_STATUS" = "Charging" ]; then
            STATUS="Charging"
        fi
    fi
done

if [ "$TOTAL_CAPACITY" -eq 0 ]; then
    echo "No battery"
else
    AVERAGE_PERCENT=$((TOTAL_PERCENT / TOTAL_CAPACITY))
    ICON=""
    
    if [ "$STATUS" = "Charging" ]; then
        ICON=$CHARGING_ICON
    elif [ "$AVERAGE_PERCENT" -le 20 ]; then
        ICON=$LOW_BATTERY_ICON
    fi
    
    echo "$ICON $AVERAGE_PERCENT%"
fi

