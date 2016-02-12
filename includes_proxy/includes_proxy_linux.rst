.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To determine the current proxy server on the |mac os x| and |linux| platforms, check the environment variables. Run the following:

.. code-block:: bash

   env | grep -i http_proxy

If an environment variable is set, it **MUST** be lowercase. If it is not, add a lowercase version of that proxy variable to the shell (e.g. ``~/.bashrc``) using one (or more) the following commands.

For HTTP:

.. code-block:: bash

   export http_proxy=http://myproxy.com:3168

For HTTPS:

.. code-block:: bash

   export https_proxy=http://myproxy.com:3168

For FTP:

.. code-block:: bash

   export ftp_proxy=http://myproxy.com:3168
