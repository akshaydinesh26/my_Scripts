
input=$1;
ref=$2

bam=($(cut -d "," -f 2 ${input}));
sample=($(cut -d "," -f 1 ${input}));

size=$(echo "${#bam[@]}");

mkdir variants;

function gatk_run {
in=$1
out=$2

gatk --java-options "-Xms16G -Xmx18G -XX:ParallelGCThreads=2" HaplotypeCaller \
-R ${ref} \
-I ${in} \
-O "variants/${out}.g.vcf.gz" \
-ERC GVCF
}

for((i=0;i<${size};i++)); \
do \
gatk_run ${bam[i]} ${sample[i]}; \
done;
