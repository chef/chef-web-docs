=====================================================
|chef init| (executable)
=====================================================

The |chef init| command is used by |chef container| to provide an entry point into a container.

This command has the following options:

``--bootstrap``
   Use to run the |chef client| a single time and then exit, causing a container to stop.

``--on-boot``
   Use to run the |chef client| a single time, but keep a container alive until it's told to stop.

``--verify``
   Use to verify that the |chef init| command is functioning correctly.
