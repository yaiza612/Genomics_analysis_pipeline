import sys
from Bio import SeqIO

homologs = set()
for line in open(sys.argv[1]):
    fields = line.strip().split('\t')
    homologs.add(fields[1])

for r in SeqIO.parse(sys.argv[2], format="fasta"):
    if r.id in homologs: 
        print('>%s\n%s' %(r.id, r.seq))
