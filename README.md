# MRSA-analysis
Alignment of 13 MRSA isolate assemblies against the *S. aureus* NCTC 8325
reference genome (NC_007795.1) for BMMB554.

Course instructor: [Anton Nekrutenko](https://github.com/nekrut)

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

## Results

Reference: NC_007795.1, 2,821,361 bp (single chromosome).

All 13 assemblies are highly contiguous (1–3 contigs each) and consistent with
typical *S. aureus* genome size.

| Assembly | Contigs | Total size (bp) | Contigs mapping to reference | Unmapped contigs |
|----------|--------:|----------------:|:-----------------------------:|:----------------:|
| assembly1  | 3 | 2,903,098 | 1 | 2 |
| assembly2  | 2 | 2,803,993 | 1 | 1 |
| assembly3  | 3 | 2,914,747 | 1 | 2 |
| assembly4  | 1 | 2,845,717 | 1 | 0 |
| assembly5  | 1 | 2,795,653 | 1 | 0 |
| assembly6  | 2 | 2,852,898 | 1 | 1 |
| assembly7  | 1 | 2,737,675 | 1 | 0 |
| assembly8  | 1 | 2,938,488 | 1 | 0 |
| assembly9  | 3 | 2,890,909 | 2 | 1 |
| assembly10 | 2 | 2,967,136 | 1 | 1 |
| assembly11 | 2 | 2,977,260 | 2 | 0 |
| assembly12 | 1 | 2,820,179 | 1 | 0 |
| assembly13 | 2 | 3,009,069 | 1 | 1 |

**Interpretation**
- Five isolates (4, 5, 7, 8, 12) assembled into a single complete chromosomal contig.
- Most multi-contig assemblies have one large chromosomal contig that maps to NCTC 8325 plus 1–2 unmapped contigs — consistent with accessory elements absent from the reference (plasmids, prophages, pathogenicity islands).
- Genome-size spread of ~270 Kbp across isolates likely reflects variation in this accessory genome content.
- Per-alignment-record mapping rate is 98.8–100% (see `alignments/stats.tsv`).

## Sample of Interest
One isolate of note: **34003-19-S005** (BioSample `SAMD00591223`, BioProject `PRJDB15501`),
collected 2019-12-17 in Hiroshima, Japan from a female patient with pneumonia. Sequenced
by both Illumina (DRR456630, ~1.5M reads) and Oxford Nanopore (DRR546383, ~6.2K reads).
Whether this isolate is among the 13 assemblies is unconfirmed — the assembly FASTA headers
contain no sample metadata. To be resolved when a manifest becomes available.

## Changelog

### 2026-04-23
- Added `Results` section with verified per-assembly contig counts, sizes, and mapping outcomes
- Corrected earlier misread: alignment-record counts from `samtools flagstat` are not contig counts — `grep -c "^>"` on the FASTA gives the true contig count (1–3 per assembly)
- Added `environment.yml` pinning `minimap2=2.30`, `samtools=1.23.1`, `entrez-direct=25.3`
- Added `metadata/samples.tsv` scaffold for sample metadata (biosample, accessions, collection info)
- Added `make stats` target — writes mapping summary to `alignments/stats.tsv`
- Added `CLAUDE.md` for agent onboarding
- Added `Makefile` for fully reproducible pipeline (download → index → align)
- Added `.gitignore` to exclude large binary outputs from future commits
- Aligned all 13 MRSA isolate assemblies to NC_007795.1 with minimap2 (`asm5`); 98.8–100% mapping rate across isolates
- Downloaded and indexed *S. aureus* NCTC 8325 reference genome (NC_007795.1) with `samtools faidx`
- Downloaded 13 MRSA isolate assemblies (`assembly1–13.fasta.gz`) from BMMB554 course dataset
- Initial repository setup
