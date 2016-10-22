.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To specify the shell type used on the nodes returned by a search query:

.. code-block:: bash

   $ knife ssh roles:opscode-omnitruck macterm
   
where ``screen`` is one of the following values: ``cssh``, ``interactive``, ``macterm``, ``screen``, or ``tmux``. If the node does not have the shell type installed, knife will return an error similar to the following:

.. code-block:: bash

   you need the rb-appscript gem to use knife ssh macterm. 
   `(sudo) gem    install rb-appscript` to install
   ERROR: LoadError: cannot load such file -- appscript


