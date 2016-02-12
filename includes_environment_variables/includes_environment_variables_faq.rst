.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

**My init script works fine when I'm logged in but not over ssh or when launched from the chef-client running as daemon!**

Shells commonly alter their environment at startup by loading various initialization scripts. The files used for initialization vary based on whether the shell is started as an interactive or non-interactive shell and whether it is is started as a login or non-login shell. When a user first logs in, most often an interactive login shell is started. When a command is run via |ssh|, this is often a non-interactive shell. This can mean that the process in question is receiving different environments. Ensure that a service or process is being started in a way that ensures its environment has the necessary key-value pairs.

**I want to change the environment for every process!**

To change the environment for new processes, alter the initialization scripts for the system shell. These scripts can be managed using the |resource template| resource; however, there are a few caveats:

* The environments of existing processes will be unaffected
* Shells look to different startup files when started with different options. See the shell-specific documentation for the definitive list of files that need to be altered and whether it is possible to alter the environment for every possible invocation of the shell
* When a shell's initialization file is first changed, it will have no affect on your current shell or process since its environment has already been initialized
* From a shell, the source command can be used to reload a given initialization file; however, since child processes do not affect their parent's environment, using a script or execute resource to run source from inside a recipe will have no effect on the environment for the |chef client|
