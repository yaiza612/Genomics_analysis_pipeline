echo "#########################################"
echo "##### AUTHOR : Yaiza Arnáiz Alcácer #####"
echo "#########################################"
echo "Running scripts for genomics analysis"
echo "#####################################"
echo "Start metagenomic analysis"
sh metagenomics_script.sh
echo "changing environment automatically"
source /home/miniconda3/etc/profile.d/conda.sh
conda activate personal
echo "#####################################"
echo "Start basic checks"
sh basic_checks_script.sh
echo "changing environment automatically"
source /home/miniconda3/etc/profile.d/conda.sh
conda activate all
echo "######################################"
echo "Start mapping"
sh mapping_script.sh
echo "######################################"
echo "Start variant calling"
sh variant_calling_script.sh
echo "#######################################"
echo "Start differential expression"
sh differential_expression_script.sh
echo "#######################################"
echo "Start funtional analysis"
sh funtional_analysis_script.sh
echo "changing environment automatically"
source /home/miniconda3/etc/profile.d/conda.sh
conda activate base
echo "#######################################"
echo "Start phylogenetic analysis"
sh phylogenetic_script.sh
echo "ordering a bit..."
mkdir BAMfiles
mv *.bam* BAMfiles
mkdir reference_genome
mv *genome.* reference_genome
mkdir proteome
mv *proteome.* proteome
mv *proteomes.* proteome
mv *vcf* variant_calling
echo "########################################"
echo "Genomic analysis done"
echo "########################################"
echo "Every analysis with the correspondant files is in its folder"
echo "You will found all the information in the reports"

