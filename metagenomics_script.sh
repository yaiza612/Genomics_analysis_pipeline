#########################################
##### AUTHOR : Yaiza Arnáiz Alcácer #####
#########################################
mkdir metagenomic_analysis
motus profile -f metagenomics-hotspring-hightemp.1.fq.gz -r metagenomics-hotspring-hightemp.2.fq.gz -o metagenomic_analysis/high_temp.motus
motus profile -f metagenomics-hotspring-normaltemp.1.fq.gz -r metagenomics-hotspring-normaltemp.2.fq.gz -o metagenomic_analysis/normal_temp.motus
# Write report 
echo  >> metagenomic_analysis/metagenomics_report.txt
echo "Report metagenomics" >> metagenomic_analysis/metagenomics_report.txt
echo  >> metagenomic_analysis/metagenomics_report.txt
# What are the most abundant organisms at normal temperature and their relative abundance
echo "Most abundant species in normal temperature" >> metagenomic_analysis/metagenomics_report.txt
grep -v "^#" metagenomic_analysis/normal_temp.motus | sort -t$'\t' -k2nr | head -n10 >> metagenomic_analysis/metagenomics_report.txt
echo  >> metagenomic_analysis/metagenomics_report.txt
echo  >> metagenomic_analysis/metagenomics_report.txt
# What are the most abundant organisms at high temperature and their relative abundance
echo "Most abundant species in high temperature" >> metagenomic_analysis/metagenomics_report.txt
grep -v "^#" metagenomic_analysis/high_temp.motus | sort -t$'\t' -k2nr | head -n10 >> metagenomic_analysis/metagenomics_report.txt
echo  >> metagenomic_analysis/metagenomics_report.txt
echo  >> metagenomic_analysis/metagenomics_report.txt
# Are the most abundants organisms present in the high-temperature samples? At which abundance?
top=$(grep -v "^#" metagenomic_analysis/normal_temp.motus | sort -t$'\t' -k2nr | head -n3 | awk '{print $1" "$2" "}')
top_array=($top)
echo "Searching for ..." ${top_array[*]} >> metagenomic_analysis/metagenomics_report.txt
echo  >> metagenomic_analysis/metagenomics_report.txt
echo "Presence of the top 3 organism of normal temperature in high temperature" >> metagenomic_analysis/metagenomics_report.txt
for ((i=0;i<=2;i++)); do grep ^"${top_array[2*i]} ${top_array[2*i+1]}" metagenomic_analysis/high_temp.motus; done >> metagenomic_analysis/metagenomics_report.txt
echo " " >> metagenomic_analysis/metagenomics_report.txt
echo "Number of species in each condition" >> metagenomic_analysis/metagenomics_report.txt
echo "Species in normal temperature: " $(grep -v '0.0000000000' metagenomic_analysis/normal_temp.motus | grep -oP '\[.*?\]' | uniq | wc -l) >> metagenomic_analysis/metagenomics_report.txt
echo "Species in high temperature: " $(grep -v '0.0000000000' metagenomic_analysis/high_temp.motus | grep -oP '\[.*?\]' | uniq | wc -l) >> metagenomic_analysis/metagenomics_report.txt
# Open the report
echo "Done, here it is the report"
cat metagenomic_analysis/metagenomics_report.txt
