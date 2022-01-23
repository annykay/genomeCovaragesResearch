while read LINE
do
        echo $LINE
	name_1=$LINE"_1.fastq"
	name_2=$LINE"_2.fastq"
	name_sam=$LINE".sam"
	name_bam=$LINE".bam"
	name_bam_sorted=$LINE"sorted.bam"
	name_bedgraph=$LINE".bedgraph"
	fasterq-dump -p -e 3 -t tmp $LINE
	hisat2 -q -p 10 -x genome -1 $name_1 -2 $name_2 -S $name_sam
	samtools view -bS $name_sam > $name_bam
	samtools sort -o $name_bam_sorted -@ 10 $name_bam
	samtools index $name_bam_sorted
	bedtools genomecov -split -ibam $name_bam_sorted -bg > $name_bedgraph                                                                
	rm $name_sam $name_bam $name_1 $name_2 $LINE
done < runs
