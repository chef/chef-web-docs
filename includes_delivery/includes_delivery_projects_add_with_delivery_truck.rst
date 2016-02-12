.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


.. note:: These instructions assume that you will use |chef delivery| as your source code source of truth and that |chef delivery| is not integrated with |github enterprise| or GitHub.com.

This topic describes the recommended setup for a |chef| cookbook project using |chef delivery|.

The following example shows how to create a cookbook, with project and pipeline, configure it to be built with ``delivery-truck`` (the open source build cookbook for |chef delivery|), and then import it into |chef delivery|. From your workstation, do the following:

#. Make a working directory (``workspace`` in the example):

   .. code-block:: bash

      $ mkdir ~/workspace && cd ~/workspace

#. Setup the ``delivery-cli`` to, by default, contact the delivery server at SERVER, with a default ENTERPRISE and ORGANIZATION:

   .. code-block:: bash

      $ delivery setup --server=SERVER --ent=ENTERPRISE --org=ORGANIZATION --user=USERNAME

   .. note:: The server, enterprise, organization, and user must already exist.

#. Create a cookbook:

   .. code-block:: bash

      $ chef generate cookbook NEW-COOKBOOK-NAME

   .. code-block:: bash

      $ cd NEW-COOKBOOK-NAME

   This uses the |chef dk| to generate a new cookbook, including a default recipe and default |chef spec| tests.

#. Create an initial commit (use ``git status`` to verify the change) on the "master" branch:

   .. code-block:: bash

      $ git add .

   .. code-block:: bash

      $ git commit -m 'Initial Commit'

   Running ``chef generate`` initialized a |git| repository automatically for this cookbook. If you created the build cookbook manually, initialize the |git| repository with the ``git init`` command.

#. Initialize the cookbook for |chef delivery|:

   .. code-block:: bash

      $ delivery init

   This creates a new project in |chef delivery|, pushes the master branch, creates a feature branch, generates a default |chef delivery| project configuration file, pushes the first change for review, and then opens a browser window that shows the change.
