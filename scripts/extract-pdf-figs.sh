#!/bin/bash

# Check if a PDF file was passed
if [ $# -eq 0 ]; then
    echo "Usage: $0 <file.pdf>"
    exit 1
fi

PDF_FILE="$1"
DIR="$(dirname "$PDF_FILE")/figures"

# Create figures directory if it doesn't exist
mkdir -p "$DIR"

# Extract images using pdfimages
# -all extracts all images in their original format
pdfimages -all "$PDF_FILE" "$DIR/page"

echo "Images extracted to $DIR"
