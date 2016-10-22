.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``collect_data`` method is a block of Ruby code that is called by Ohai when it runs. One (or more) ``collect_data`` blocks can be defined in a plugin, but only a single ``collect_data`` block is ever run. The ``collect_data`` block that is run is determined by the platform on which the node is running, which is then matched up against the available ``collect_data`` blocks in the plugin. 

* A ``collect_data(:default)`` block is used when Ohai is not able to match the platform of the node with a ``collect_data(:platform)`` block in the plugin
* A ``collect_data(:platform)`` block is required for each platform that requires non-default behavior

When Ohai runs, if there isn't a matching ``collect_data`` block for a platform, the ``collect_data(:default)`` block is used. The syntax for the ``collect_data`` method is:

.. code-block:: ruby

   collect_data(:default) do
     # some Ruby code
   end

or: 

.. code-block:: ruby

   collect_data(:platform) do
     # some Ruby code
   end

where:

* ``:default`` is the name of the default ``collect_data`` block
* ``:platform`` is the name of a platform, such as ``:aix`` for AIX or ``:windows`` for Microsoft Windows
