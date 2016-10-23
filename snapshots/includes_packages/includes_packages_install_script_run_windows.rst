.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


On Microsoft Windows systems the Omnitruck install script is invoked using Windows PowerShell:

.. code-block:: none

   . { iwr -useb https://omnitruck.chef.io/install.ps1 } | iex; install
