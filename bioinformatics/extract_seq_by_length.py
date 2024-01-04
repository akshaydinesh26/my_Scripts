#!/usr/bin/python3

#execute as python3 script.py <fasta file> <min_size>
from Bio import SeqIO
import sys

#for seq_record in SeqIO.parse("transimproved.fasta","fasta"):
#  print(seq_record.id)
#  print(repr(seq_record.seq))
#  print(len(seq_record))

#files for output
passed_id=open('passed.txt','w')
passed_seq=open('final.fasta','w')

#find sequence with length greater than given input min_size
no_pass = 0
total = 0
for sequ in SeqIO.parse(sys.argv[1],"fasta"):
  if(len(sequ) > int(sys.argv[2])):
    no_pass+=1
    total+=1
    passed_id.write(str(sequ.id))
    passed_id.write('\n')
    SeqIO.write(sequ,passed_seq,"fasta")
  else:
    total+=1

passed_id.close()
passed_seq.close()

print('no of sequences passed filter:',no_pass)
print('total no of sequences:',total)
