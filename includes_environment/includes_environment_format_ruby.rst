.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Each environment is defined as a |ruby| file (i.e. a file that ends with ``.rb``). Each environment file should contain the following domain-specific attributes:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``cookbook``
     - |ruby dsl cookbook| For example:

       .. code-block:: ruby

          cookbook 'couchdb', '< 11.0.0'

       or:

       .. code-block:: ruby

          cookbook 'my_rails_app', '< 1.2.0'

       or:

       .. code-block:: ruby

          cookbook 'gems', '< 1.4.0'

   * - ``cookbook_versions``
     - |ruby dsl cookbook version| For example:

       .. code-block:: ruby

          cookbook_versions({
            'couchdb'=>'= 11.0.0',
            'my_rails_app'=>'~> 1.2.0'
          })

   * - ``default_attributes``
     - |ruby dsl default attribute| For example, to specify that a node that has the attribute ``apache2`` should listen on ports 80 and 443 (unless ports are already specified):

       .. code-block:: ruby

          default_attributes 'apache2' => { 'listen_ports' => [ '80', '443' ] }

   * - ``description``
     - |ruby dsl description| For example:

       .. code-block:: ruby

          description 'The development environment'

   * - ``name``
     - |ruby dsl name| For example:

       .. code-block:: ruby

          name 'dev01-24'

   * - ``override_attributes``
     - |ruby dsl override attribute| For example:

       .. code-block:: ruby

          override_attributes 'apache2' => { 'max_children' => '50' }

       The parameters in a |ruby| file are actually |ruby| method calls, so parentheses can be used to provide clarity when specifying numerous or deeply-nested attributes. For example:

       .. code-block:: ruby

          override_attributes(
            :apache2 => { 
              :prefork => { :min_spareservers => '5' }
            }
          )

       or:

       .. code-block:: ruby

          override_attributes(
            :apache2 => {
              :prefork => { :min_spareservers => '5' }
            },
            :tomcat => {
              :worker_threads => '100'
            }
          )  

A |ruby| file for each non-default environment must exist in the ``environments/`` subdirectory of the |chef repo|. (If the |chef repo| does not have this subdirectory, then it should be created.) The complete environment has the following syntax:

.. code-block:: ruby

   name 'environment_name'
   description 'environment_description'
   cookbook OR cookbook_versions  'cookbook' OR 'cookbook' => 'cookbook_version'
   default_attributes 'node' => { 'attribute' => [ 'value', 'value', 'etc.' ] }
   override_attributes 'node' => { 'attribute' => [ 'value', 'value', 'etc.' ] }

where both default and override attributes are optional and either a cookbook or cookbook versions (one or more) are specified. For example, an environment named ``dev`` that uses the ``couchdb`` cookbook (version 11.0.0 or higher) that listens on ports 80 and 443:

.. code-block:: ruby

   name 'dev'
   description 'The development environment'
   cookbook_versions  'couchdb' => '= 11.0.0'
   default_attributes 'apache2' => { 'listen_ports' => [ '80', '443' ] }

Or (using the same scenario) to specify a version constraint for only one cookbook:

.. code-block:: ruby

   cookbook 'couchdb', '= 11.0.0'

More than one cookbook version can be specified:

.. code-block:: ruby

   cookbook_versions({
     'couchdb'=>'= 11.0.0',
     'my_rails_app'=>'~> 1.2.0'
   })

Attributes are optional and can be set at the default and override levels. These will be processed according to attribute precedence. An environment attribute will be applied to all nodes within the environment, except in places where it is overridden by an attribute with higher precedence. For example:

.. code-block:: ruby

   default_attributes 'apache2' => { 'listen_ports' => [ '80', '443' ] }

will have all nodes in the environment (``node[:apache2][:listen_ports]``) set to ``'80'`` and ``'443'`` unless they were overridden by an attribute with higher precedence. For example:

.. code-block:: ruby

   override_attributes 'apache2' => { 'listen_ports' => [ '99', '999' ] }
