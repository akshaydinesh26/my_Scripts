#!/usr/bin/bash

cat primary_assembly/*fasta > merged.fasta
cd-hit-est -i merged.fasta -o combined_cdhit.fasta -c 0.95 -d 0 -n 8 -M 10000 -T 10
