#!/usr/bin/env fish

# Create screenshots directory if it doesn't exist
set SCREENSHOT_DIR ~/Pictures/screenshots
mkdir -p $SCREENSHOT_DIR

#!/usr/bin/env fish

# Create screenshots directory if it doesn't exist
set SCREENSHOT_DIR ~/Pictures/screenshots
mkdir -p $SCREENSHOT_DIR

# Generate filename with timestamp
set TIMESTAMP (date +"%Y-%m-%d_%H-%M-%S")
set FILENAME "$SCREENSHOT_DIR/screenshot_$TIMESTAMP.png"

# Take screenshot with slurp and grim
set GEOMETRY (slurp)

# Check if user canceled selection
if test $status -ne 0
    # Notify user that selection was canceled
    dunstify -a Screenshot "Screenshot canceled" "Selection was canceled"
    exit 1
end

# Take the screenshot
grim -g "$GEOMETRY" "$FILENAME"

# Copy to clipboard
cat "$FILENAME" | wl-copy --type image/png

# Send notification with direct command execution
# This uses dunstify's native action handling instead of a separate process
dunstify -a Screenshot "Screenshot saved" "Saved to $FILENAME" \
    -A "default,Open in Satty" \
    --icon="$FILENAME" \
    --action-callback "satty -i '$FILENAME'"
