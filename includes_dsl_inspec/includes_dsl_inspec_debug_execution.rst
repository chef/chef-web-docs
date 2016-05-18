.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|ruby| code used in custom audit resources and controls is executed on the system that runs |inspec|. This allows |inspec| to work without requiring |ruby| and |rubygems| on a remote target. For example, using ```ls``` or ``system('ls')`` will result in the ``ls`` command being run locally and not on the target(remote) system. In order to process the output of ``ls`` as executed on the target system, use ``command('ls')`` or ``powershell('ls')``. Similarly, use ``file(PATH)`` to access files or directories from remote systems in your tests or custom resources.
