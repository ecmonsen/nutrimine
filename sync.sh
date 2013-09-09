#!/bin/sh


## To use, export NUTRIMINE_DEST or supply it when running this bash script
## on the command line
##
## e.g. NUTRIMINE_DEST=blah@blah:/blah/blah ./sync.sh

set -e
set -x

# change to directory of this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

# do the sync: rsync over ssh
rsync -ave ssh --exclude-from=exclude-list.txt site/ "$NUTRIMINE_DEST"

