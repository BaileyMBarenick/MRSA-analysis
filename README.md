# MRSA-analysis
Alignment of 13 MRSA isolate assemblies against the *S. aureus* NCTC 8325
reference genome (NC_007795.1) for BMMB554.

## Structure
```
assemblies/   13 MRSA isolate assemblies (assembly1–13.fasta.gz)
alignments/   Per-isolate sorted BAM files and minimap2 logs
reference.fasta       S. aureus NCTC 8325 reference (NC_007795.1)
reference.fasta.fai   samtools index
```

## Reproducing
Dependencies: `minimap2`, `samtools`, `entrez-direct` (all available via conda/bioconda)

```bash
make        # download reference, index, align all 13 assemblies
make clean  # remove reference and alignment outputs
```
