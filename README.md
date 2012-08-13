# DIRCAT

Dircat build, starting from a directory, a catalog with files meta information (path, timestamp, md5. ...), so it
is possible to compare this catalog with another directory to detect duplicate, file change, and so.
This utilities could be utilized as help to backup a directory or to find duplicates

= Simple Cataloger

An extremly simple cataloging tool. You can use it to index files stored on
hard disks and create searchable catalogs that can be used without having access to original media.

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

### Rubies

see [gem-testers][http://gem-testers.org/gems/dircat/]
and contribute to the test :-)

### INSTALL:

sudo gem install dircat

or

sudo gem install gf-dircat -s gems.github.com

== Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

== Copyright

Copyright (c) 2009-2012 Tokyro (tokyro.oyama@gmail.com). See LICENSE for details.
