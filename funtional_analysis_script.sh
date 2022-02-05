
#########################################
##### AUTHOR : Yaiza Arnáiz Alcácer #####
#########################################
mkdir functional_analysis
REF=proteome.faa
overexpressed=$(cat differential_expression/de_result.txt | sort -k3,3r | awk '{print $1}' | head -n -2 | tail -n +2)
#Save to FASTA
echo "Saving FASTA"
for i in $overexpressed;
do
grep -A1 $i $REF > functional_analysis/$i.faa
echo "see the sequence we just save in a fasta file:"
cat functional_analysis/$i.faa
done
echo "Work done"

