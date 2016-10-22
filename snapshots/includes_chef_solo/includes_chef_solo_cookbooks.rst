.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


chef-solo supports two locations from which cookbooks can be run: 

* A local directory.
* A URL at which a tar.gz archive is located. 

Using a tar.gz archive is the more common approach, but requires that cookbooks be added to an archive. For example:

.. code-block:: bash 

   $ tar zcvf chef-solo.tar.gz ./cookbooks

If multiple cookbook directories are being used, chef-solo expects the tar.gz archive to have a directory structure similar to the following::

   cookbooks/
     |---- cbname1/
       |--attributes/ ... etc
     ...
     |---- cbname2/
       |--attributes/

The ``cookbook_path`` variable in the solo.rb file must include both directories. For example:

.. code-block:: bash

   $ tar zcvf chef-solo.tar.gz ./cookbooks ./site-cookbooks

When the tar.gz archive contains all of the cookbooks required by chef-solo, upload it to the web server from which chef-solo will access the archive.
