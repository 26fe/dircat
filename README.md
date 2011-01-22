# DIRCAT

Dircat build, starting from a directory, a catalog with files meta information (path, timestamp, md5. ...), so it
is possible to compare this catalog with another directory to detect duplicate, file change, and so.
This utilities could be utilized as help to backup a directory or to find duplicates

### dircat build

Build a catalog from a directory

Ex.: dircat build -o <catalog_name> dir1

builds catalog from directory dir1.

### dircat cfr

Compare two catalogs or directories

Ex. dircat diff spec/fixtures/dir1 spec/fixtures/dir2

### dircat query

query the contents of catalog

Ex.: ruby bin/dircat query cat_dir1.yaml
Ex.: ruby bin/dircat query cat_dir1.yaml duplicates

### INSTALL:

sudo gem install dircat

or

sudo gem install gf-dircat -s gems.github.com

### Copyright

Copyright (c) 2009-2010 tokiro.oyama@gmail.com See LICENSE for details.
