#!/bin/bash
set -euo pipefail

# Download the archive
curl -sSL -o lab3-bundle.tar.gz https://s3.amazonaws.com/ds2002-resources/labs/lab3-bundle.tar.gz

# Extract it (contains lab3_data.tsv)
tar -xzf lab3-bundle.tar.gz

# Remove blank / whitespace-only lines.
# NOTE: The first line of lab3_data.tsv is not the header; it is a stray shell
# prompt ("practice [main]$ cat 03-cleaning/mock_data.tsv") that was captured
# when the file was created. NR > 1 drops that line so the real header
# (id, first_name, ...) becomes row 1 of the cleaned file. Without this, the
# data row count below would be one too high (97 instead of 96), because the
# real header would be counted as a data row.
awk 'NR > 1 && !/^[[:space:]]*$/' lab3_data.tsv > cleaned.tsv

# Convert tabs to commas
tr '\t' ',' < cleaned.tsv > cleaned.csv

# Count data rows (excluding the header) and report
DATA_ROWS=$(tail -n +2 cleaned.csv | wc -l | tr -d ' ')
echo "Data rows remaining: $DATA_ROWS"

# Package the cleaned CSV
tar -czf converted-archive.tar.gz cleaned.csv
