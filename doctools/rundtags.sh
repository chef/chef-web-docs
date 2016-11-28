#!/bin/bash

echo 'running dtags check'

cd chef_master/source
../../doctools/dtags check

RESULT=$?
if [ $RESULT -ne 0 ]; then
  (>&2 echo 'dtags checked failed')
  (>&2 echo '  The Chef docs team will make tagged regions consistent prior' )
  (>&2 echo '  prior to merging your PR (may take a few days longer), or you can' )
  (>&2 echo '  use the dtags tool yourself. See chef-web-docs README.md for more ' )
  (>&2 echo '  information about tagged regions. ' )
  exit 1
fi
