# Genomics_analysis_pipeline
I created an automated pipeline that realize the complete genomics analysis of GDAV lectures 2021/2022


## Usage 

1. Copy the folder of the final project (there are no permissions to edit this folder)
2. Copy the all the scripts into the new folder created
3. Run main.sh
 
```
sh main.sh  
```
The script will change the environment automatically when it is needed and run all the rest of scripts in the correct order.
Also print in the screen the whole process so you can see what it is doing everytime. 

## Output

You will obtain the following folders: 

* metagenomics_analysis : with the correspondant files and the report of metagenomics.
* basic_checks : with the report of basic_checks
* mapping : with the report of mapping 
* differential_expression : with the plots in pdf (to use it latex), the table with the results of the differential expression analysis, the file with the counts and the annotated table with the gene name and function
*  functional_analysis : with the fasta files of the overexpressed genes. 
*  phylogenetic_analysis : with the files correspondant to the blastp search (orthologs) and the trefiles. 
*  BAMfiles: with all the BAM files generated during the pipeline
*  reference_genome : with the genome reference file and the correspondant index files
*  proteome: all the files with the proteomes 

The pipeline is made specifically for the lectures of the course of GDAV and only work with the structure of the given folder "final_project". 
In the future, I will improve it adding argument choices and automatical checks to be able to run the pipeline given any type
of genomic data.


