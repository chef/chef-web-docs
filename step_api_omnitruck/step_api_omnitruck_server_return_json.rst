.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To get metadata information (as |json|) data, enter the following:

.. code-block:: bash

   $ curl -H "Accept: application/json" 'https://www.chef.io/chef/metadata-server?p=ubuntu&pv=12.04&m=x86_64'

to return something like:

.. code-block:: javascript

   {
     "relpath": "/ubuntu/12.04/x86_64/chef-server_11.0.8-1.ubuntu.12.04_amd64.deb",
     "md5": "076bfc8409ef2bc1818c9c515b472b82",
     "sha256": "29fa28a18d48bcc8d8e557d4c2dd94386abb6b20cfc341fff62444401d76351c",
     "url": "https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chef-server_11.0.8-1.ubuntu.12.04_amd64.deb"
   }
