#!/usr/bin/bash

busco -i combined_cdhit.fasta\
 -o gssRNA\
 -m tran\
 -l poales_odb10\
 --out_path BUSCO_out
  
