
#!/bin/bash

# Check if a PDF file was passed
if [ $# -eq 0 ]; then
    echo "Usage: $0 <file.pdf>"
    exit 1
fi

PDF_FILE="$1"
DIR="$(dirname "$PDF_FILE")/figures"

# Create figures directory
mkdir -p "$DIR"

# Temporary folder for raw images
TMP_DIR="$(mktemp -d)"

# Extract all images (original format)
pdfimages -all "$PDF_FILE" "$TMP_DIR/page"

# Convert all images to PNG and rename them nicely
count=1
for img in "$TMP_DIR"/*; do
    printf -v num "%03d" "$count"
    convert "$img" "$DIR/figure_$num.png"
    ((count++))
done

# Clean up temporary folder
rm -rf "$TMP_DIR"

echo "Images extracted and converted to PNG in $DIR"
