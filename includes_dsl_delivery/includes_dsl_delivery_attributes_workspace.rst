.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use attributes from the ``node['delivery']['workspace']`` namespace to get paths to workspace directories on a build node.

``cache``
   Use ``node['delivery']['workspace']['cache']`` for the ``/cache`` directory.

``chef``
   Use ``node['delivery']['workspace']['chef']`` for the ``/chef`` directory.

``root``
   Use ``node['delivery']['workspace']['root']`` for the root directory, typically ``/var/opt/delivery/workspace``.

``repo``
   Use ``node['delivery']['workspace']['repo']`` for the ``/repo`` directory.
