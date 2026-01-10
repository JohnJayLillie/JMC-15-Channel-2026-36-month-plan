#!/bin/bash
free_ram=$(vm_stat | grep "Pages free" | awk '{print $3}' | sed 's/\.//')
page_size=$(vm_stat | head -1 | awk '{print $8}')
free_gb=$(echo "scale=2; ($free_ram * $page_size) / 1073741824" | bc)

echo "Free RAM: ${free_gb} GB"

if (( $(echo "$free_gb < 4" | bc -l) )); then
    echo "⚠️  Low memory. Close apps before running SDXL"
else
    echo "✓ Sufficient memory available"
fi
