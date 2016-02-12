.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


.. To initialize a |dockerfile| context for an image named "chef/demo" that has a ``run_list`` of ``recipe[apache2]``:

.. code-block:: bash

   $ knife container docker init docker -r 'recipe[apache2]' -z -b

will create a directory named ``docker`` with a subdirectory named ``demo`` in the ``Chef::Config[:knife][:dockerfiles_path]`` path. In the ``docker`` directory, a subdirectory named ``chef`` is created, which contains all of the files and folders that are necessary for the |chef client| to run successfully inside a container. The |dockerfile| is similar to:

.. code-block:: ruby

   FROM chef/ubuntu_12.04
   ADD chef /etc/chef
   RUN chef-init --bootstrap
   ENTRYPOINT ["chef-init"]
   CMD ["--onboot"]
