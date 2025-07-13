#!/bin/bash

# ---------------------------
# Log Archive Tool
# ---------------------------

# 1. Check if log directory is passed
if [ -z "$1" ]; then
  echo "Usage: $0 <log-directory>"
  exit 1
fi

LOG_DIR="$1"

# 2. Check if provided directory exists
if [ ! -d "$LOG_DIR" ]; then
  echo "Error: Directory '$LOG_DIR' does not exist."
  exit 1
fi

# 3. Define archive destination
ARCHIVE_DIR="/var/log-archive"
mkdir -p "$ARCHIVE_DIR"

# 4. Generate timestamp and archive file name
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz"
ARCHIVE_PATH="${ARCHIVE_DIR}/${ARCHIVE_NAME}"

# 5. Compress the logs from the given directory
tar -czf "$ARCHIVE_PATH" -C "$LOG_DIR" .

# 6. Record the activity in a log file
LOG_FILE="${ARCHIVE_DIR}/log-archive.log"
echo "[$(date +"%Y-%m-%d %H:%M:%S")] Archived '$LOG_DIR' to '$ARCHIVE_PATH'" >> "$LOG_FILE"

# 7. Final user message
echo "✅ Logs from '$LOG_DIR' archived to: $ARCHIVE_PATH"

