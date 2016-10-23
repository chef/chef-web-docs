.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To join queries using the ``AND`` boolean operator, enter the following:

.. code-block:: bash

   $ knife search sample "id:b* AND animal:dog"

to return something like:
   
.. code-block:: bash
   
   {
     "total": 1,
     "start": 0,
     "rows": [
       {
         "comment": "an item named baz",
         "id": "baz",
         "animal": "dog"
       }
     ]
   }

Or, to find all of the computers running on the Microsoft Windows platform that are associated with a role named ``jenkins``, enter:

.. code-block:: bash

   $ knife search node 'platform:windows AND roles:jenkins'

to return something like:

.. code-block:: bash

   2 items found
   
   Node Name:   windows-server-2008r2.domain.com
   Environment: _default
   FQDN:        windows-server-2008r2
   IP:          0000::0000:0000:0000:0000
   Run List:    role[jenkins-windows]
   Roles:       jenkins-windows, jenkins
   Recipes:     jenkins-client::windows, jenkins::node_windows
   Platform:    windows 6.1.7601
   Tags:        
   
   Node Name:   123-windows-2008r2-amd64-builder
   Environment: _default
   FQDN:        ABC-1234567890AB
   IP:          123.45.6.78
   Run List:    role[123-windows-2008r2-amd64-builder]
   Roles:       123-windows-2008r2-amd64-builder, jenkins
   Recipes:     jenkins::node_windows, git_windows
   Platform:    windows 6.1.7601
   Tags:        
