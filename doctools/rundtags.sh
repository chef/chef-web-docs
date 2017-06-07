#!/bin/bash

echo 'running dtags check'

cd chef_master/source
../../doctools/dtags check

DTAGSRESULT=$?
if [ $DTAGSRESULT -ne 0 ]; then
  (>&2 echo 'dtags checked failed')
  (>&2 echo '  The Chef docs team will make tagged regions consistent prior' )
  (>&2 echo '  to merging your PR (may take a few days longer), or you can' )
  (>&2 echo '  use the dtags tool yourself. See chef-web-docs README.md for more ' )
  (>&2 echo '  information about tagged regions. ' )
fi

echo 'checking for edit links'

../../doctools/lint_edit_check

EDITRESULT=$?
if [ $EDITRESULT -ne 0 ]; then
  (>&2 echo 'lint_edit_check failed')
  (>&2 echo '  The edit on GitHub link must be added to the top of every topic in our doc set.' )
  (>&2 echo '  The Chef docs team will add this in prior to merging your PR ' )
  (>&2 echo '  or you can add the link in yourself. ' )
fi

if [ $DTAGSRESULT -ne 0 ] || [ $EDITRESULT -ne 0 ]; then
  exit 1
fi

echo 'Done.'
