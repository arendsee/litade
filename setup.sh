#!/bin/bash

taxdat=parent-children.txt

# Download taxonomy database
if [ ! -s nodes.dmp ]; then
    wget -O taxdmp.zip ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdmp.zip
    if [ $? != 0 ]; then
        echo 'Failed to download taxonomy database' > /dev/stderr
        exit 1
    fi
    unzip taxdmp.zip nodes.dmp
    rm taxdmp.zip
fi

gawk '{a[$3] = a[$3]","$1}
      END{
           for (v in a) {print v, a[v]}
      }' nodes.dmp | sed 's/ ,/ /' > $taxdat
rm nodes.dmp 
