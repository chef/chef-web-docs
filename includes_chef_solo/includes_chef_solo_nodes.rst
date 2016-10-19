.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Unlike |chef client|, where the node object is stored on the |chef server|, |chef solo| stores its node objects as |json| files on disk. By default, |chef solo| stores these files in a ``nodes`` folder in the same directory as your ``cookbooks`` directory. You can control the location of this directory via the ``node_path`` value in your configuration file.
