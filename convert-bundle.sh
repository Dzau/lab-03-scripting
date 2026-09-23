#!/bin/bash
set -euo pipefail

# Download the archive
curl -sSL -o lab3-bundle.tar.gz https://s3.amazonaws.com/ds2002-resources/labs/lab3-bundle.tar.gz

# Extract it (contains lab3_data.tsv)
tar -xzf lab3-bundle.tar.gz

# Remove blank / whitespace-only lines (NR > 1 drops the stray prompt line at the top)
awk 'NR > 1 && !/^[[:space:]]*$/' lab3_data.tsv > cleaned.tsv

# Convert tabs to commas
tr '\t' ',' < cleaned.tsv > cleaned.csv

# Count data rows (excluding the header) and report
DATA_ROWS=$(tail -n +2 cleaned.csv | wc -l | tr -d ' ')
echo "Data rows remaining: $DATA_ROWS"

# Package the cleaned CSV
tar -czf converted-archive.tar.gz cleaned.csv
