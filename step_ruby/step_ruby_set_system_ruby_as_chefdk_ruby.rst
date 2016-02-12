.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

For many users of |chef|, the |chef dk| version of |ruby| that is included in the |chef dk| should be configured as the default version of |ruby|.

#. Open a command window and enter the following:

   .. code-block:: bash

      $ which ruby

   which will return something like ``/usr/bin/ruby``.
#. To use the |chef dk| version of |ruby| as the default |ruby|, edit the ``$PATH`` and ``GEM`` environment variables to include paths to the |chef dk|. For example, on a machine that runs |bash|, run:

   .. code-block:: bash

      echo 'eval "$(chef shell-init bash)"' >> ~/.bash_profile

   where ``bash`` and ``~/.bash_profile`` represents the name of the shell.

   If zsh is your preferred shell then run the following:

   .. code-block:: bash

    echo 'eval "$(chef shell-init zsh)"' >> ~/.zshrc

#. Run ``which ruby`` again. It should return ``/opt/chefdk/embedded/bin/ruby``.

.. note:: Using the |chef dk|-provided |ruby| as your system |ruby| is optional. This just depends on how you are using |ruby| on your system. For many users, |ruby| is primarily used for authoring |chef| cookbooks and recipes. If that's true for you, then using the |chef dk|-provided |ruby| as your system |ruby| is recommended. But for other users who are already using tools like |rbenv| to manage |ruby| versions, then that's OK too.

