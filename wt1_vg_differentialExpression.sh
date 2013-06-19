# Evaluating the quality of reads

# cd /data;

# mkdir /root/Dropbox/fastqc_${dataset}

# /usr/local/share/FastQC/fastqc ${reads_1} ${reads_2} --outdir=/root/Dropbox/fastqc_${dataset}:

# Trimming by quality values

## python /usr/local/share/khmer/sandbox/interleave.py ${reads_1} ${reads_2} > combined_${dataset}.fq;

## fastx_trimmer -Q33 -l 70 -i combined_vg1.fq | fastq_quality_filter -Q33 -q 30 -p 50 > combined-trim_${dataset}.fq;

# Evaluating quality after trimming

## mkdir /root/Dropbox/fastqc.filt_${dataset};
## /usr/local/share/FastQC/fastqc combined-trim_${dataset}.fq  --outdir=/root/Dropbox/fastqc.filt_${dataset};

# Mapping to reference genome with Tophat

# mkdir /mnt/tophat_${dataset}
# tophat -p 4 -G /data/${transcript_annotation} -o /mnt/tophat_${dataset} /root/${reference_index} /data/${reads_1} /data/${reads_2}

# cd /mnt/tophat_${dataset}
# mv accepted_hits.bam accepted_hits_${dataset}.bam

# samtools sort accepted_hits_${dataset}.bam accepted_hits_${dataset}.sorted
# samtools index accepted_hits_${dataset}.sorted.bam

# Assembling transcripts

# mkdir /mnt/cufflinks_${dataset}
# cd /mnt/cufflinks_${dataset}
# cufflinks -o /mnt/cufflinks_${dataset}/${dataset}_ /mnt/tophat_${dataset}/accepted_hits_${dataset}.bam

# Combine reference annotation file and newly generated annotation file

cuffcompare -o /mnt/cufflinks_${dataset}/${dataset}_ -s /mnt/dmel-all-chromosome-r5.51.fasta -CG -r /data/Drosophila_melanogaster.BDGP5.71.gtf /mnt/cufflinks_${dataset}/${dataset}_transcripts.gtf


