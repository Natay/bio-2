# Convert to GFF {#bio-gff}

## Building a nicer gene model

`bio` creates more meaningful  and nicer GFF visualizations:

    # Get chromosome 2L for Drosophila melanogaster (fruit-fly)
    bio NT_033779 --fetch --rename fly 

convert it to gff:

    bio fly --gff > annotations.gff
    
## GFF created with `bio`
   
Here is a region from the GFF file created with the code above as visualized in IGV:

```{r fig.align='center', echo=FALSE}
knitr::include_graphics('images/gff-model-bio.png', dpi = NA)
```

The features are explicit, well separated, colored by type, and easier to see and interpret. 
Below is the same region of the GFF file as downloaded from NCBI. We believe it is more difficult to understand.

```{r fig.align='center', echo=FALSE}
knitr::include_graphics('images/gff-model-ncbi.png', dpi = NA)
```

`bio` follows the definitions in the [Sequence Ontology][SO]. In the GFF files created with `bio` an exon will parented to a transcript, a CDS will belong to an mRNA. NCBI will use the mRNA as the parent for both types.

    gene --> transcript --> exon
    gene --> mRNA --> CDS

Other considerations:

* Exons have `transcript_id` and `gene_id` attributes set.
* CDS features have `protein_id` and `gene_id` attributes set.

[SO]: http://www.sequenceontology.org/


## Convert all features to GFF:

```{bash, comment=NA}
bio ncov --gff | head -5
```

## Convert to GFF only the features with type `CDS`

```{bash, comment=NA}
bio ncov --gff --type CDS | head -5
```

## Convert to GFF only the features tagged with gene `S`

```{bash, comment=NA}
bio ncov --gff --gene S | head -5
```

## Convert to GFF only the features that overlap a interval

```{bash, comment=NA}
bio ncov --gff --start 2000 --end 3000 | head -5
```
