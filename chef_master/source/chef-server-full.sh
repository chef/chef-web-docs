#!/bin/bash
FILES=*.rst
for f in $FILES
do
  # extension="${f##*.}"
  filename="${f%.*}"
  echo "updating $f"
  sed -i 's&``chef-server.rb``&``/etc/opscode/chef-server.rb``&' $f
done
