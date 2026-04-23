# MRSA-analysis
Alignment of 13 MRSA isolate assemblies against the *S. aureus* NCTC 8325
reference genome (NC_007795.1) for BMMB554.

## Overview
Methicillin-resistant *Staphylococcus aureus* (MRSA) is a clinically significant
pathogen responsible for difficult-to-treat infections. This project aligns 13
assembled MRSA isolate genomes against the well-characterized NCTC 8325 reference
strain to enable comparative genomic analysis — identifying structural variation,
accessory genome content, and potential resistance or virulence determinants across
isolates.

Assemblies were sourced from the BMMB554 course dataset. Alignment was performed
with minimap2 using the `asm5` preset, appropriate for same-species assemblies with
low divergence (~0.1%). All 13 isolates achieved 98.8–100% mapping rate against the
2.82 Mbp reference chromosome.

## Structure
```
assemblies/           13 MRSA isolate assemblies (assembly1–13.fasta.gz)
alignments/           Per-isolate sorted BAM + index + minimap2 logs
reference.fasta       S. aureus NCTC 8325 reference (NC_007795.1)
reference.fasta.fai   samtools faidx index
Makefile              Reproducible pipeline
```

## Reproducing
Dependencies: `minimap2`, `samtools`, `entrez-direct` (all available via conda/bioconda)

```bash
make        # download reference, index, align all 13 assemblies
make clean  # remove reference and alignment outputs
```

## Sample of Interest
One isolate of note: **34003-19-S005** (BioSample `SAMD00591223`, BioProject `PRJDB15501`),
collected 2019-12-17 in Hiroshima, Japan from a female patient with pneumonia. Sequenced
by both Illumina (DRR456630, ~1.5M reads) and Oxford Nanopore (DRR546383, ~6.2K reads).
Whether this isolate is among the 13 assemblies is unconfirmed — the assembly FASTA headers
contain no sample metadata. To be resolved when a manifest becomes available.

## Changelog

### 2026-04-23
- Added `Makefile` for fully reproducible pipeline (download → index → align)
- Added `.gitignore` to exclude large binary outputs from future commits
- Aligned all 13 MRSA isolate assemblies to NC_007795.1 with minimap2 (`asm5`); 98.8–100% mapping rate across isolates
- Downloaded and indexed *S. aureus* NCTC 8325 reference genome (NC_007795.1) with `samtools faidx`
- Downloaded 13 MRSA isolate assemblies (`assembly1–13.fasta.gz`) from BMMB554 course dataset
- Initial repository setup
