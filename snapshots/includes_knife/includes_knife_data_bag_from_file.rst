.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``from file`` argument to:

* Add a data bag item to a data bag
* Update the contents of an existing data bag item 

The data bag itself must already exist on the Chef server and must be specified as part of the command. The contents of the data bag item are specified using a JSON file. This JSON file may be located at a relative or absolute path; its location must be specified as part of the command. The JSON file that defines the contents of the data bag item must at least contain the name of the data bag item---``"id": "name"``.

.. warning:: A chef-client must be version 11.6 (or higher) when using the ``knife data bag from file`` argument with the Enterprise Chef or Open Source Chef version 11 servers.
