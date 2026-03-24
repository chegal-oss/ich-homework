#!/bin/bash
read -p "Enter IP address: " TARGET
if [ -z "$TARGET" ]; then
    TARGET=127.0.0.1
fi

FAILED_COUNT=0
THRESHOLD=100

echo "------------------------------------"

while true; do
    RESULT=$(LC_ALL=C ping -c 1 -W 1000 -t 2 "$TARGET" 2>/dev/null)
    EXIT_CODE=$?
    if [ $EXIT_CODE -eq 0 ]; then
        FAILED_COUNT=0
        LATENCY=$(echo "$RESULT" | awk -F'[= ]' '/time/ {print $(NF-1)}')
        LATENCY_INT=${LATENCY%.*}
        if [[ -n "$LATENCY_INT" ]] && [ "$LATENCY_INT" -gt "$THRESHOLD" ]; then
            echo "[!] High latency: ${LATENCY} ms ($(date '+%H:%M:%S'))"
        else 
            echo "$TARGET - Alles in Ordnung"
        fi
    else
        ((FAILED_COUNT++))
        if [ "$FAILED_COUNT" -ge 3 ]; then
            echo "[!!!] Ping fails already $FAILED_COUNT times! ($(date '+%H:%M:%S'))"
        fi
    fi
    sleep 1
done