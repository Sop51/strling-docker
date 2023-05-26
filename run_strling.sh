#!/bin/bash

crams=$1
fasta=$2
cramsidx=$3
fastaidx=$4

process_cram_file() {
    cram_file=$1

    chmod 777 "$cram_file"

    # copy crais to same folder as crams (tibanna puts in own folder)
    sname=$(basename "$cram_file" .cram)
    directory=$(dirname "$cram_file")
    cp $cramsidx "${directory}/${sname}.cram.crai"

    fname=$(basename "$fasta")
    directory=$(dirname "$fasta")
    cp "$fastaidx" "${directory}/${fname}.fai"

    mkdir -p str-bins/
    /usr/local/bin/strling extract -f "$fasta" "$cram_file" "str-bins/${sname}.bin"
    mkdir -p str-results/
    mkdir -p "str-results/${sname}/"
    mkdir -p "str-logs/${sname}/"

    /usr/local/bin/strling call --output-prefix "str-results/${sname}/${sname}" -f "$fasta" "$cram_file" "str-bins/${sname}.bin" > "str-logs/${sname}.log"
}

export -f process_cram_file

# Run the process_cram_file function in parallel for each CRAM file
parallel --jobs 2 process_cram_file ::: $crams

# Ensure all parallel jobs are completed before proceeding
wait


