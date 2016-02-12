.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

In-between each step in a deployment process, callbacks can be run using arbitrary |ruby| code, including recipes. All callbacks support embedded recipes given in a block, but each callback assumes a shell command (instead of a deploy hook filename) when given a string.

The following callback types are available:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Callback
     - Description
   * - ``after_restart``
     - |after_restart| Default value: ``deploy/after_restart.rb``.
   * - ``before_migrate``
     - |before_migrate| Default value: ``deploy/before_migrate.rb``.
   * - ``before_restart``
     - |before_restart| Default value: ``deploy/before_restart.rb``.
   * - ``before_symlink``
     - |before_symlink| Default value: ``deploy/before_symlink.rb``.

Each of these callback types can be used in one of three ways:

* To pass a block of code, such as |ruby| or |python|
* To specify a file
* To do neither; the |chef client| will look for a callback file named after one of the callback types (``before_migrate.rb``, for example) and if the file exists, to evaluate it as if it were a specified file

Within a callback, there are two ways to get access to information about the deployment:

* ``release_path`` can be used to get the path to the current release
* ``new_resource`` can be used to access the deploy resource, including environment variables that have been set there (using ``new_resource`` is a preferred approach over using the ``@configuration`` variable)

Both of these options must be available at the top-level within the callback, along with any assigned values that will be used later in the callback.
