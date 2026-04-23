REFERENCE   = reference.fasta
ASSEMBLIES  = $(wildcard assemblies/*.fasta.gz)
BAMS        = $(patsubst assemblies/%.fasta.gz,alignments/%.bam,$(ASSEMBLIES))

.PHONY: all stats clean

all: $(REFERENCE).fai $(BAMS)

# Download and index reference
$(REFERENCE):
	efetch -db nucleotide -id NC_007795.1 -format fasta > $@

$(REFERENCE).fai: $(REFERENCE)
	samtools faidx $<

# Download assemblies
assemblies/assembly%.fasta.gz:
	mkdir -p assemblies
	curl -sL https://raw.githubusercontent.com/nekrut/bda/main/data/assemblies/assembly$*.fasta.gz -o $@

# Align each assembly to reference
alignments/%.bam: assemblies/%.fasta.gz $(REFERENCE).fai
	mkdir -p alignments
	minimap2 -a -x asm5 $(REFERENCE) $< 2> alignments/$*.log | samtools sort -o $@
	samtools index $@

stats: $(BAMS)
	@echo "assembly\ttotal_reads\tmapped\tmapping_rate" > alignments/stats.tsv
	@for bam in $(BAMS); do \
		name=$$(basename $$bam .bam); \
		total=$$(samtools flagstat $$bam | awk 'NR==1{print $$1}'); \
		mapped=$$(samtools flagstat $$bam | awk '/^[0-9]+ \+ [0-9]+ mapped \(/{print $$1; exit}'); \
		rate=$$(samtools flagstat $$bam | awk '/^[0-9]+ \+ [0-9]+ mapped \(/{gsub(/[()]/,""); print $$5; exit}'); \
		echo "$$name\t$$total\t$$mapped\t$$rate"; \
	done >> alignments/stats.tsv
	@cat alignments/stats.tsv

clean:
	rm -f $(REFERENCE) $(REFERENCE).fai
	rm -rf alignments/
