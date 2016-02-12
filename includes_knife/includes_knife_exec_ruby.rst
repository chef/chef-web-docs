.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


For |ruby| scripts that will be run using the ``exec`` subcommand, note the following:

  * The |ruby| script must be located on the system from which |knife| is run (and not be located on any of the systems that |knife| will be managing).
  * Shell commands will be run from a management workstation. For example, something like ``%x[ls -lash /opt/only-on-a-node]`` would give you the directory listing for the "opt/only-on-a-node" directory or a "No such file or directory" error if the file does not already exist locally.
  * When the |chef shell| DSL is available, the |chef client| DSL will not be (unless the management workstation is also a |chef client|). Without the |chef client| DSL, a bash block cannot be used to run bash commands.

