#!/bin/bash
set -e

# Directory to search
SEARCH_DIR=$1
ARCHIVE_DIR=$2

# Ensure the script receives exactly two arguments
if [[ "$#" -ne 2 ]]; then
    echo "Usage: $0 SEARCH_DIR ARCHIVE_DIR"
    exit 1
fi

# Ensure the search directory exists
if [[ ! -d "$SEARCH_DIR" ]]; then
    echo "The directory $SEARCH_DIR does not exist."
    exit 1
fi

# Ensure the archive directory exists, or create it
if [[ ! -d "$ARCHIVE_DIR" ]]; then
    mkdir -p "$ARCHIVE_DIR"
fi

# Find and compress files larger than 10MB or older than 10 days, then move to archive folder
find "$SEARCH_DIR" -type f \( -size +10M -o -mtime +10 \) -exec gzip {} \; -exec mv {}.gz "$ARCHIVE_DIR" \;

echo "Compression and archiving completed."
