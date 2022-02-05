ete3 view --text -t phylogenetic_analysis/results_$i.alg.treefile
#########################################
##### AUTHOR : Yaiza Arnáiz Alcácer #####
#########################################
mkdir phylogenetic_analysis
public_genome=all_reference_proteomes.faa
#Create blast database
makeblastdb -dbtype prot -in $public_genome
#run blast search for the overexpressed CDS, extract all the homologs and do multiple sequence alignment
overexpressed=$(ls functional_analysis)
for i in ${overexpressed[*]};
do
blastp -task blastp -query functional_analysis/$i -db $public_genome -outfmt 6 -evalue 0.001 > phylogenetic_analysis/$i.txt
cp functional_analysis/$i phylogenetic_analysis
python extract_sequences_from_blast_result.py phylogenetic_analysis/$i.txt $public_genome >> phylogenetic_analysis/$i
mafft phylogenetic_analysis/$i > phylogenetic_analysis/results_$i.alg
iqtree -s phylogenetic_analysis/results_$i.alg -m LG -fast;
# visualizing
echo "here we can see our tree unrooted"
ete3 view --text -t phylogenetic_analysis/results_$i.alg.treefile
echo "here we can see our tree rooted in midpoint"
python /home/compgenomics/4proteomes/scripts/midpoint_rooting.py phylogenetic_analysis/results_$i.alg.treefile | ete3 view --text
done


