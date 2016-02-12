.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The |service solr4| service located on the primary back end machine handles requests that are made from the |erchef| service that is located on all front end machines in a |chef server| cluster.

Under normal circumstances, |opscode solr4| will need access to a total of 2x the space used for the index.

The thread at http://comments.gmane.org/gmane.comp.jakarta.lucene.solr.user/99149 explains more fully, including describing an extreme case where it's possible that 3x the storage might be necessary. |chef server| usage of |apache solr| via the |service solr4| service will generally only require the used storage for the index + 1x that amount of storage in free space.

For example, a 2GB search index will require about 2GB of free space available in the |service solr4| service's storage area. The standard storage area for the |service solr4| service in a |standalone| topology |chef server| install is ``/var/opt/opscode/opscode-solr4/data``.
