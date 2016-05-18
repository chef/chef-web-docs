.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


On |windows| systems the |omnitruck| install script is invoked using |windows powershell|:

.. code-block:: powershell

   . { iwr -useb https://omnitruck.chef.io/install.ps1 } | iex; install