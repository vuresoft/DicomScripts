#!/bin/bash

# Function to print debug messages
debug() {
    echo "Debug: $1"
}

# Check if an input parameter (directory path) is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path-to-dicom-directory>"
    exit 1
fi

# Assign the input parameter to DICOM_DIR
DICOM_DIR="$1"
debug "DICOM directory: $DICOM_DIR"

# Check if the provided directory exists
if [ ! -d "$DICOM_DIR" ]; then
    echo "Error: Directory $DICOM_DIR does not exist."
    exit 1
fi

# Create a subdirectory for compressed files if it doesn't exist
OUTPUT_DIR="$DICOM_DIR/compressed"
if [ ! -d "$OUTPUT_DIR" ]; then
    mkdir "$OUTPUT_DIR"
fi
debug "Output directory: $OUTPUT_DIR"

# Loop through all files in the directory
shopt -s nullglob
for file in "$DICOM_DIR"/*; do
    debug "Found file: $file"

    # Check if the file is a DICOM file (by extension)
    if [[ $file = *.sh ]]; then
        debug "Skipping non-DICOM file: $file"
        continue
    fi

        if [[ $file = *.txt ]]; then
        debug "Skipping non-DICOM file: $file"
        continue
    fi

    # Extract filename without extension
    filename=$(basename -- "$file")
    filename="${filename%.*}.dcm"

        # Attempt to compress the file using JPEG-LS lossless compression
    if dcmcjpls "$file" "$OUTPUT_DIR/${filename}"; then
        echo "Successfully compressed: $file"
                echo "${filename}" >> "../imagefilelist.txt"

    else
        echo "Compression failed for: $file, copying original"
        cp "$file" "$OUTPUT_DIR/${filename}"
    fi




done

echo "Compression complete."
