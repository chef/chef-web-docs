.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the following steps to set up a development repository for Chef:

#. Set up a GitHub account.
#. Fork the https://github.com/chef/chef repository to your GitHub account.
#. Clone the https://github.com/chef/chef repository:

   .. code-block:: bash

      $ git clone git@github.com:yourgithubusername/chef.git

#. From the command line, browse to the ``chef/`` directory:

   .. code-block:: bash

      $ cd chef/

#. From the ``chef/`` directory, add a remote named ``chef``:

   .. code-block:: bash

      $ git remote add chef git://github.com/chef/chef.git

#. Verify:

   .. code-block:: bash

      $ git config --get-regexp "^remote\.chef"

   which should return something like:

   .. code-block:: bash

      remote.chef.url git://github.com/chef/chef.git
      remote.chef.fetch +refs/heads/*:refs/remotes/chef/*

#. Adjust your branch to track the ``chef/master`` remote branch:

   .. code-block:: bash

      $ git config --get-regexp "^branch\.master"

   which should return something like:

   .. code-block:: bash

      branch.master.remote origin
      branch.master.merge refs/heads/master

   and then change it:

   .. code-block:: bash

      $ git config branch.master.remote chef
