wget    https://sra-pub-run-odp.s3.amazonaws.com/sra/SRR7187305/SRR7187305
wget    https://sra-pub-run-odp.s3.amazonaws.com/sra/SRR7187300/SRR7187300
wget    https://sra-pub-run-odp.s3.amazonaws.com/sra/SRR7187301/SRR7187301
wget    https://sra-pub-run-odp.s3.amazonaws.com/sra/SRR7187298/SRR7187298
wget    https://sra-pub-run-odp.s3.amazonaws.com/sra/SRR7187299/SRR7187299
wget    https://sra-pub-run-odp.s3.amazonaws.com/sra/SRR7187296/SRR7187296
wget    https://sra-pub-run-odp.s3.amazonaws.com/sra/SRR7187297/SRR7187297
wget    https://sra-pub-run-odp.s3.amazonaws.com/sra/SRR7187294/SRR7187294
wget    https://sra-pub-run-odp.s3.amazonaws.com/sra/SRR7187295/SRR7187295
wget    https://sra-pub-run-odp.s3.amazonaws.com/sra/SRR7187302/SRR7187302
wget    https://sra-pub-run-odp.s3.amazonaws.com/sra/SRR7187303/SRR7187303                                                                          
while read LINE
do
        echo $LINE
	name_1=$LINE"_1.fastq"
	name_2=$LINE"_2.fastq"
	name_sam=$LINE".sam"
	name_bam=$LINE".bam"
	name_bam_sorted=$LINE"sorted.bam"
	name_bedgraph=$LINE".bedgraph"
	fastq-dump --split-files $LINE
	hisat2 -q -p 10 -x genome -1 $name_1 -2 $name_2 -S $name_sam
	samtools view -bS $name_sam > $name_bam
	samtools sort -o $name_bam_sorted -@ 10 $name_bam
	samtools index $name_bam_sorted
	bedtools genomecov -ibam $name_bam_sorted -bg > $name_bedgraph                                                                
	rm $name_sam $name_bam $name_1 $name_2 $LINE
done < runs
~

