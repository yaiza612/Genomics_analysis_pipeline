#########################################
##### AUTHOR : Yaiza Arnáiz Alcácer #####
#########################################
mkdir basic_checks
echo "Genomic report" >> basic_checks/genomic_report.txt
echo  >> basic_checks/genomic_report.txt
# How many samples we have?
echo "Number of samples:" >> basic_checks/genomic_report.txt
list_fasta=$(ls RNAseq)
number_fasta=$(ls RNAseq | wc -l)
r=2
expr $number_fasta / $r >> basic_checks/genomic_report.txt
arr_fasta=($list_fasta)
echo  >> basic_checks/genomic_report.txt
#number read, length, header of each sample
for ((i=0;i<=3;i++));
do
file=${arr_fasta[2*i]}
echo "Sample: " $file
# this script needs seqkit to run, I installed in a new environment call personal and the main script change the environment
# to be able to run it
echo "Type: " $(seqkit stat RNAseq/$file | tail -n1 | awk '{ print $3 }')
echo "Maximum length of the reads: " $(seqkit stat RNAseq/$file | tail -n1 | awk '{ print $8 }')
echo "Minimum length of the reads: " $(seqkit stat RNAseq/$file | tail -n1 | awk '{ print $6 }')
echo "Number of reads: " $(seqkit stat RNAseq/$file | tail -n1 | awk '{ print $4 }');
done >> basic_checks/genomic_report.txt
echo "Work done, here it is the report"
cat basic_checks/genomic_report.txt
