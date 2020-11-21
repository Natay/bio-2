#
# This script is used to generate Python tests.
#

#
# The output generate by each test can be seen at:
#
# https://github.com/ialbert/bio/tree/master/test/data
#

# Stop on errors.
set -uex

# Delete the ncov data if exists. Here for testing.
bio ncov --delete

# Fetch the accession, rename the data and change the sequence id.
bio NC_045512 --fetch --rename ncov --seqid ncov

# You can also fetch and convert at the same time.
bio NC_045512 --fetch --fasta --end 100 > fetch-convert.fa

# Shows the internal JSON format of the data.
bio ncov > ncov.json

# Convert to GenBank.
bio ncov --genbank > ncov.gb

# Convert to FASTA.
bio ncov --fasta > ncov.fa

# Convert to GFF.
bio ncov --gff > ncov.gff

# Filter the internal JSON by regular expression match and type.
bio ncov --match ORF1ab --type gene > match.json

# Convert to GFF features associated with a gene.
bio ncov --gff --gene S > gene1.gff

# Convert to GFF features that overalp with start to end.
bio ncov --gff  --start 10000 --end 20000 > overlap.gff

# Convert to GFF by type.
bio ncov --gff  --type CDS > type.gff

# Convert to GFF by multiple types.
bio ncov --gff  --type gene,CDS,mRNA > multiple-types.gff

# Slice a FASTA to a region and change the sequence id.
bio ncov --fasta --seqid foo --start 10 --end 20 > fasta-start.fa

# Convert to FASTA features with a certain type.
bio ncov --fasta --type CDS > CDS.fa

# Convert to FASTA a sub region of type filtered data.
bio ncov --fasta --type gene --end 10 > gene-start.fa

# Translate the DNA for features that have the type CDS.
bio ncov --translate --type CDS > translate.fa

# Extract already(!) translated proteins from the data. The translation attribute must be filled in GenBank.
bio ncov --protein --start -10 > protein-end.fa

# There are shortcuts to accesing coding sequences for genes.
# The following two commands are equivalent.
bio ncov --fasta --type CDS --gene S --end 10 > shortcut.fa
bio ncov:S --fasta --end 10 > shortcut.fa

# Extract the already traslated protein from the data.
bio ncov:S --fasta --protein --seqid foo > s_prot_foo.fa

# Interactive mode. Data obtained from the command line paramter
bio ATGGGC -i --fasta > inter.fa

# Translate in interactive mode.
bio ATGGGC -i --translate >  inter-trans.fa

# Translate on the reverse complement.
bio ATGGGC -i --revcomp --translate > inter-revcomp1.fa

# You can separately reverse and complement
bio ATGGGC -i --reverse --complement --translate >  inter-revcomp2.fa

# Get the RaTG13 data.
bio MN996532 --fetch --rename ratg13 --seqid ratg13

# Align the first 200 bp across both genomes.
bio ncov ratg13 --end 210 --align > align-dna.txt

# Align the DNA for the coding sequences of the S protein.
bio ncov:S ratg13:S --end 210 --align > align-dna-s.txt

# Align the translated DNA for the coding sequences of the S protein. Slice appled to DNA.
bio ncov:S ratg13:S --end 210 --translate --align > align-translated-s.txt

# Align the already translated proteins. Slice applied to the protein.
bio ncov:S ratg13:S --protein --end 70 --align > align-protein-s.txt

# Local alignment in interactive mode.
bio THISLINE ISALIGNED  -i --align --local > align-local.txt

# Global alignment in interactive mode.
bio THISLINE ISALIGNED -i --align --global > align-global.txt

# Semiglobal alignment in interactive mode.
bio THISLINE ISALIGNED -i --align --semiglobal > align-semiglobal.txt

# Check taxonomy defaults
bio 9606 --taxon > taxon_9606.txt

# Generate lineage.
bio 9606 --lineage --taxon > taxon_9606_lineage.txt

# The lineage may be flattened to a single line.
bio 9606 --lineage --flat --taxon > taxon_9606_flat_lineage.txt

# Taxonomy information from data.
bio ncov ratg13 --taxon > taxon_ncov_ratg13.txt
