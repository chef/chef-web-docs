.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Once created, an environment can be managed in several ways:

* By using |knife| and passing the ``-E ENVIRONMENT_NAME`` option with ``knife cookbook upload``
* By using the |chef manage| web user interface
* By using |ruby| or |json| files that are stored in a version source control system. These files are pushed to the |chef server| using the |subcommand knife environment| subcommand and the ``from file`` argument. This approach allows environment data to be dynamically generated. This approach will not work unless these files are defined in the proper format---|ruby| file end with ``.rb``; |json| files end with ``.json``.

These workflows are mutually exclusive: only the most recent environment changes will be kept on the |chef server|, regardless of the source of those changes. All previous changes are overwritten when environment data is updated.

The settings for environments can be modified and environments can be integrated into the larger infrastructure by associating them with nodes and by using recipes to call specific environment settings.
