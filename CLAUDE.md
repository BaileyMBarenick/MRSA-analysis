# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project
BMMB554 course project. 13 MRSA isolate assemblies aligned against *S. aureus* NCTC 8325 (NC_007795.1) for comparative genomic analysis. Instructor: [Anton Nekrutenko](https://github.com/nekrut).

## Pipeline
All steps are encoded in the `Makefile`. Dependencies: `minimap2`, `samtools`, `entrez-direct` — install via conda/bioconda if missing.

```bash
make              # reproduce everything from scratch
make clean        # remove reference and alignments (assemblies kept)
```

Individual targets:
- `reference.fasta` — downloaded via `efetch` from NCBI
- `reference.fasta.fai` — samtools index of reference
- `alignments/assemblyN.bam` — minimap2 `asm5` alignment, sorted and indexed

## Data
- `assemblies/assembly1–13.fasta.gz` — gzipped FASTA assemblies, generic `contig_1` headers (no embedded sample metadata)
- `alignments/` — sorted BAM + `.bai` index + `.log` per isolate; 98.8–100% mapping rate
- Large binaries (`.bam`, `.fasta`, `.fasta.gz`) are gitignored and reproducible via `make`

## Open Questions
- Sample **34003-19-S005** (BioSample `SAMD00591223`, Hiroshima, pneumonia, 2019-12-17) may be among the 13 assemblies but cannot be confirmed — assembly headers carry no accession info. Flag if a manifest or metadata file is ever found linking assembly filenames to sample IDs.
- Next analysis steps to be defined in the following class session.
