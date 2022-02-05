
#########################################
##### AUTHOR : Yaiza Arnáiz Alcácer #####
#########################################
mkdir mapping
REF=genome.fasta
# Create the genome index
bwa index $REF
# Run the aligner in paired end mode
list_fasta=$(ls RNAseq)
arr_fasta=($list_fasta)
for ((i=0;i<=3;i++));
do
R1=${arr_fasta[2*i]}
echo "reading ..." $R1
R2=${arr_fasta[2*i+1]}
echo "reading ..." $R2
IFS=. read -r x y z w <<< "$R1"
bwa mem $REF RNAseq/$R1 RNAseq/$R2 > $x.sam ;
done
# create the bamfiles with the header -h
list_sam=$(ls *.sam)
arr_sam=($list_sam)
echo "List of samfiles availables..." ${arr_sam[*]}
for ((i=0;i<=3;i++));
do
S=${arr_sam[i]}
echo "Creating bam file of ..." $S
IFS=. read -r q r <<< "$S"
samtools view -S -b -h $S > $q.bam ;
done
# remove the samfiles
rm *.sam
# prepare report
echo "Mapping report" >> mapping/mapping_report.txt
echo >> mapping/mapping_report.txt
# how many records are in the bam files, how many reads? How these numbers compare to each other?
list_bam=$(ls *.bam)
arr_bam=($list_bam)
echo "List of bamfiles availables..." ${arr_bam[*]}
for ((i=0;i<=3;i++));
do
B=${arr_bam[i]}
echo "Sample: " $B
echo "Total number of records/entries: " $(samtools view -c $B)
echo "Total number of mapped reads: " $(samtools view -c -F 260 $B)
echo "Aligment statistics :"
python aligment_statitics.py $B;
done >> mapping/mapping_report.txt
# Finish
echo "Work done, here is the report"
cat mapping/mapping_report.txt
