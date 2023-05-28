#!/bin/bash

cram=$1
fasta=$2
cramidx=$3
fastaidx=$4

fname=$(basename "$fasta")
ro_ref_dir=$(dirname "$fasta")
ln -s "$fastaidx" "${directory}/${fname}.fai"

samtools faidx "${ref_dir}/${fname}"


mkdir -p str-bins/
/usr/local/bin/strling extract -f "$fa" "${cram_dir}/${sname}.cram" "str-bins/${sname}.bin"
mkdir -p str-results/
mkdir -p "str-results/${sname}/"
mkdir -p "str-logs/${sname}/"

/usr/local/bin/strling call --output-prefix "str-results/${sname}/${sname}" -f "$fa" "${cram_dir}/${sname}.cram" "str-bins/${sname}.bin" > "str-logs/${cname}.log"


fname=$(basename "$fasta")
ro_ref_dir=$(dirname "$fasta")

sname=$(basename "$cram_file" .cram)
ro_cram_dir=$(dirname "$cram_file")

ln -s "$fastaidx" "${ro_ref_dir}/${fname}.fai"
ln -s "$cramidx" "${ro_cram_dir}/${sname}.cram.crai"

mkdir -p str-bins/
/usr/local/bin/strling extract -f "$fasta" "$cram" "str-bins/${sname}.bin"
mkdir -p str-results/
mkdir -p "str-results/${sname}/"
mkdir -p "str-logs/${sname}/"
/usr/local/bin/strling call --output-prefix "str-results/${sname}/${sname}" -f "$fasta" "$cram" "str-bins/${sname}.bin" > "str-logs/${sname}.log"

