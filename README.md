litade
======

List input taxa species-level descendents

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

```
# Extract gis from taxa of interest
gis=$(./litade.pl 3701 | cut -f2 | tr '\n' '|')
awk -v t=$gis '$2 =~ t {print $1}' gi_taxid_prot.map > gi-list.txt
# Convert gi-list to binary
blastdbcmd 
# BLAST against these specific gi
blastp -query a.faa -db /db/blastdb/ncbi/nr -gilist gi-list.txt
# Or make a BLAST database alias specific to this taxon
blastalias_tool 
```
