TO DO
- per-serving nutrients
- suck in data
- sources


These notes are partly reconstructed from import work I did a long time ago, and partly new instructions.

* Open `sr26_doc.pdf` in adobe reader, copy into textwrangler (do not save as text - line endings are messed up). Save as `sr26_paste.txt`
* Replace goofy character in front of "Links to" lines with nothing
* Run command:

    `grep -E "(file name = )|(^Links to)" sr26_paste.txt | perl -pe 's/(^[^L].*$)/\n$1/' | perl -pe 's/(.*)\(file name = ([^\)]*).*$/$2 $1/' > foreign_keys.txt`
