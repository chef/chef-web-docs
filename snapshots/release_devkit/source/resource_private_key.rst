.. THIS PAGE IS IDENTICAL TO docs.chef.io/resource_private_key.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /release/devkit/ PATH.

=====================================================
private_key
=====================================================

.. warning:: .. include:: ../../includes_notes/includes_notes_provisioning.rst

Use the **private_key** resource to create, delete, and regenerate private keys, including RSA, DSA, and .pem file keys.

Syntax
=====================================================
The syntax for using the **private_key** resource in a recipe is as follows:

.. code-block:: ruby

   private_key 'name' do
     attribute 'value' # see properties section below
     ...
     action :action # see actions section below
   end

where 

* ``private_key`` tells the chef-client to use the ``Chef::Provider::PrivateKey`` provider during the chef-client run
* ``name`` is the name of the resource block; when the ``path`` property is not specified as part of a recipe, ``name`` is also the name of the private key
* ``attribute`` is zero (or more) of the properties that are available for this resource
* ``:action`` identifies which steps the chef-client will take to bring the node into the desired state

Actions
=====================================================
This resource has the following actions:

``:create``
   Default. Use to create an RSA private key.

``:delete``
   Use to delete an RSA private key.

``:nothing``
   .. include:: ../../includes_resources_common/includes_resources_common_actions_nothing.rst

``:regenerate``
   Use to regenerate an RSA private key.

Properties
=====================================================
This resource has the following properties:

``cipher``
   Use to specify the cipher for a .pem file. Default value: ``DES-EDE3-CBC``.
   
``exponent``
   Use to specify the exponent for an RSA private key. This is always an odd integer value, often a prime Fermat number, and typically ``5``, ``17``, ``257``, or ``65537``.
   
``format``
   Use to specify the format of a private key. Possible values: ``pem`` and ``der``. Default value: ``pem``.
   
``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.
   
``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies_syntax.rst
   
``pass_phrase``
   Use to specify the pass phrase for a .pem file.
   
``path``
   Use to specify the path to a private key. Set to ``none`` to create a private key in-memory and not on-disk. Default value: the ``name`` of the resource block. See "Syntax" section above for more information.
   
``public_key_format``
   Use to specify the format of a public key. Possible values: ``der``, ``openssh``, and ``pem``. Default value: ``openssh``.
   
``public_key_path``
   The path to a public key.
   
``regenerate_if_different``
   Use to regenerate a private key if it does not have the desired size, type, and so on. Default value: ``false``.
   
``retries``
   **Ruby Type:** Integer

   The number of times to catch exceptions and retry the resource. Default value: ``0``.
   
``retry_delay``
   **Ruby Type:** Integer

   The retry delay (in seconds). Default value: ``2``.
   
``size``
   Use to specify the size of an RSA or DSA private key. Default value: ``2048``.
   
``source_key``
   Use to copy a private key, but apply a different ``format`` and ``password``. Use in conjunction with ``source_key_pass_phrase``` and ``source_key_path``.
   
``source_key_pass_phrase``
   The pass phrase for the private key. Use in conjunction with ``source_key``` and ``source_key_path``.
   
``source_key_path``
   The path to the private key. Use in conjunction with ``source_key``` and ``source_key_pass_phrase``.
   
``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes_syntax.rst
   
``type``
   Use to specify the type of private key. Possible values: ``dsa`` and ``rsa``. Default value: ``rsa``.

.. 
.. Providers
.. =====================================================
.. .. include:: ../../includes_resources_common/includes_resources_common_provider.rst
.. 
.. .. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst
.. 
.. .. include:: ../../includes_resources/includes_resource_private_key_providers.rst
.. 

Examples
=====================================================
None.
