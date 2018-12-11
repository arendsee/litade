[![deprecated](http://badges.github.io/stability-badges/dist/deprecated.svg)](http://github.com/badges/stability-badges)

litade
======

List input taxa species-level descendents

This program is deprecated. Try using the R packages `taxize` or `taxizedb` instead.

Examples
========

Where 9606 is the taxon id for humans

```
$ litade.pl 9606
9606 63221
9606 741158
$ taxid2sciname 741158 63221
741158	Homo sapiens ssp. Denisova
63221	Homo sapiens neanderthalensis
```

BLAST specifically against Arabidopsis subset of local nr database

```
# Extract gis from taxa of interest
gis=$(./litade.pl 3701 | cut -f2 | tr '\n' '|' | sed -r 's/\|$//')
awk -v t=$gis '$2 ~ t {print $1}' gi_taxid_prot.dmp > gi-list.txt
blastdb_aliastool -gi_file_in gi-list.txt -gi_file_out gi-list.bgl
blastp -query a.faa -db /db/blastdb/ncbi/nr -gilist gi-list.bgl -num_threads `nproc`
```

Or make a BLAST database alias specific to this taxon

```
blastdb_aliastool -db /db/blastdb/ncbi/nr -dbtype prot -gilist gi-list.bgl -title Arabidopsis -out Arabidopsis
blastp -query a.faa -db Arabidopsis -num_threads `nproc`
```
