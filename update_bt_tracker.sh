#!/bin/bash

TRACKERS_URL="https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_best.txt"
ARIA2_CONF="aria2.conf"

# Fetch the latest best tracker list
echo "Fetching the latest tracker list..."
TEMP_FILE=$(mktemp)
curl -s "$TRACKERS_URL" -o "$TEMP_FILE"

if [ $? -ne 0 ]; then
    echo "Error: Failed to fetch tracker list."
    rm -f "$TEMP_FILE"
    exit 1
fi

# Convert tracker list to aria2.conf format
echo "Formatting tracker list..."
TRACKERS=$(awk '{if (NR == 1) printf $0; else printf ","$0}' "$TEMP_FILE" | sed 's/,,/,/g')
echo $TRACKERS
rm -f "$TEMP_FILE"

# Update or add the bt-tracker line in aria2.conf
echo "Updating bt-tracker in $ARIA2_CONF..."
if grep -q "^bt-tracker=" "$ARIA2_CONF"; then
    sed -i '' "s|^bt-tracker=.*|bt-tracker=$TRACKERS|" "$ARIA2_CONF"
else
    echo "bt-tracker=$TRACKERS" >> "$ARIA2_CONF"
fi

echo "bt-tracker updated successfully in $ARIA2_CONF."
