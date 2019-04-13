#!/bin/bash
FILES=*.rst
for f in $FILES
do
  # extension="${f##*.}"
  filename="${f%.*}"
  echo "Converting $f to $filename.html.md"
  `/Users/nb/.local/bin/pandoc $f -t gfm -o $f`
  `sed '/chef_master/d' $f`
  `sed 's/sourceCode//g' $f`
  `sed '/```/s/ //g' $f`
  `git mv $f $filename.html.md`
Done
