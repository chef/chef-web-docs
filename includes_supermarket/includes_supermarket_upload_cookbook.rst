.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To upload a cookbook to |supermarket|, do the following:

#. Install the ``knife supermarket`` plugin:

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

   .. code-block:: bash

      $ knife supermarket share mycookbook "Other"
