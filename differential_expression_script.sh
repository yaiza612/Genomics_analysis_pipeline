#########################################
##### AUTHOR : Yaiza Arnáiz Alcácer #####
#########################################
mkdir differential_expression
# Calculate the counts
REF=genome.gff
list_sorted_bam=$(ls *.sorted.bam)
arr_sorted=($list_sorted_bam)
echo "index the files"
for ((i=0;i<=3;i++));
do
samtools index -b ${arr_sorted[i]};
done
echo "files indexed"
echo "Counting the following ..." ${arr_sorted[*]}
# high temperature
type1=${arr_sorted[0]}
IFS=. read -r a b c <<< "$type1"
# normal temperature
type2=${arr_sorted[2]}
IFS=. read -r y x z <<< "$type2"
echo "counting..."
# high temperature
htseq-count -i locus_tag -t CDS -f bam ${arr_sorted[0]} $REF > differential_expression/01_counts_$a.txt
htseq-count -i locus_tag -t CDS -f bam ${arr_sorted[1]} $REF > differential_expression/02_counts_$a.txt
# normal temperature
htseq-count -i locus_tag -t CDS -f bam ${arr_sorted[2]} $REF > differential_expression/01_counts_$y.txt
htseq-count -i locus_tag -t CDS -f bam ${arr_sorted[3]} $REF > differential_expression/02_counts_$y.txt
# create common file of counts
join differential_expression/01_counts_$a.txt differential_expression/02_counts_$a.txt | join - differential_expression/01_counts_$y.txt\
| join - differential_expression/02_counts_$y.txt > differential_expression/result_counts.txt
echo "merging files ..."
head -n -5 differential_expression/result_counts.txt > differential_expression/temp.txt ; mv differential_expression/temp.txt\
 differential_expression/result_counts.txt
echo "starting differential expression analysis..."
# run the script of R
Rscript de_script.r differential_expression/result_counts.txt
# create the annotations
locus_id=$(cat differential_expression/de_result.txt | awk '{print $1}' | tail -n +2)
to_grep=$(echo $locus_id | tr -s ' '|tr ' ' '|')
grep -E $to_grep genome.gff | grep -o -P  '(?<=ID=).*' | tr -s ' ' | tr ' ' '_' | egrep 'gene=' |\
 awk -F";" '{for(i=1;i<=NF;i++){if ($i ~ /gene/){print $1, $i, $(i+3)}}}' | column -t | sed s/"gene="// | sed s/"product="//\
> differential_expression/annotations.txt
echo 'locus_tag gene_name function log2_fold_change lfcSE stat pvalue padj' > differential_expression/annotated.txt
cat differential_expression/de_result.txt | tail -n +2 > differential_expression/temp.txt
echo 'annotating the differential expression results'
sort -k1 differential_expression/temp.txt
sort differential_expression/annotations.txt
join -a 1 -e NULL -1 1 -2 1 -o 1.1,2.2,2.3,1.2,1.3,1.4,1.5,1.6,1.7 differential_expression/temp.txt differential_expression/annotations.txt >> differential_expression/annotated.txt
rm differential_expression/temp.txt
echo 'annotated table created'

