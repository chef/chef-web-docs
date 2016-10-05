.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To upload a cookbook to |supermarket|, do the following:

#. Determine which version of Chef you are using.

   If you are using Chef 12.13 or later, you have everything you need in the knife cookbook site commands

   If you are using Chef 12.12 or earler, you need to install the ``knife supermarket`` plugin:

   .. code-block:: bash

      $ chef gem install knife-supermarket

#. Add a setting for |supermarket| to the |knife rb| file:

   .. code-block:: ruby

      knife[:supermarket_site] = 'https://default-centos-66'

#. Resolve |ssl| errors by fetching, and then verifying the |ssl| certificate for |supermarket|:

   .. code-block:: bash

      $ knife ssl fetch https://default-centos-66

   and then:

   .. code-block:: bash

      $ knife ssl check https://default-centos-66

#. Upload the cookbook to |supermarket|:

   If you are using Chef 12.13 or later:

   .. code-block:: bash

      $ knife cookbook site share mycookbook "Other"

   If you are using Chef 12.12 or earlier:

   .. code-block:: bash

      $ knife supermarket share mycookbook "Other"
