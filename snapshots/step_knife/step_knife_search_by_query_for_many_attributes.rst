.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To build a search query to use more than one attribute, use an underscore (``_``) to separate each attribute. For example, the following query will search for all nodes running a specific version of Ruby:

.. code-block:: bash

	$ knife search node "languages_ruby_version:1.9.3"
