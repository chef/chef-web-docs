.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 

To install the |chef dk|:

#. Visit this page: http://downloads.chef.io/chef-dk/. The |chef dk| supports |mac os x|, |redhat enterprise linux|, |ubuntu|, and |windows|.
#. Select a platform, and then a package. (|chef docs| uses the |mac os x| setup within the documentation.)
#. Click the download button.
#. Follow the steps in the installer and install the |chef dk| to your machine. The |chef dk| is installed to ``/opt/chefdk/`` on |unix| and |linux| systems. 
#. When finished, open a command window and enter the following:

   .. code-block:: bash
   
      $ chef verify
   
   This will verify the main components of the |chef dk|: the |chef client|, the |chef dk| library, and the tools that are built into the |chef dk|. The output should be similar to:
   
   .. code-block:: bash

      Running verification for component '...'
      ..........
      ---------------------------------------------
      Verification of component '...' succeeded.

#. Optional. Set the default shell. On |windows| it is strongly recommended to use |windows powershell| and cmd.exe.