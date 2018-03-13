=====================================================
kitchen-vagrant
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/plugin_kitchen_vagrant.rst>`__

.. tag test_kitchen_driver_vagrant

The ``kitchen-vagrant`` driver for Kitchen generates a single Vagrantfile for each instance of Kitchen in a sandboxed directory. The ``kitchen-vagrant`` driver supports VirtualBox and VMware Fusion, requires Vagrant 1.1.0 (or higher), and is the default driver for Test Kitchen.

.. end_tag

.. tag test_kitchen_driver_vagrant_settings

The following attributes are used to configure ``kitchen-vagrant`` for Chef:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Attribute
     - Description
   * - ``box``
     - Required. Use to specify the box on which Vagrant will run. Default value: computed from the platform name of the instance.
   * - ``box_check_update``
     - Use to check for box updates. Default value: ``false``.
   * - ``box_url``
     - Use to specify the URL at which the configured box is located. Default value: computed from the platform name of the instance, but only when the Vagrant provider is VirtualBox- or VMware-based.
   * - ``communicator``
     - Use to override the ``config.vm.communicator`` setting in Vagrant. For example, when a base box is a Microsoft Windows operating system that does not have SSH installed and enabled, Vagrant will not be able to boot without a custom Vagrant file. Default value: ``nil`` (assumes SSH is available).
   * - ``customize``
     - A hash of key-value pairs that define customizations that should be made to the Vagrant virtual machine. For example: ``customize: memory: 1024 cpuexecutioncap: 50``.
   * - ``guest``
     - Use to specify the ``config.vm.guest`` setting in the default Vagrantfile.
   * - ``gui``
     - Use to enable the graphical user interface for the defined platform. This is passed to the ``config.vm.provider`` setting in Vagrant, but only when the Vagrant provider is VirtualBox- or VMware-based.
   * - ``network``
     - Use to specify an array of network customizations to be applied to the virtual machine. Default value: ``[]``. For example: ``network: - ["forwarded_port", {guest: 80, host: 8080}] - ["private_network", {ip: "192.168.33.33"}]``.
   * - ``pre_create_command``
     - Use to run a command immediately prior to ``vagrant up --no-provisioner``.
   * - ``provider``
     - Use to specify the Vagrant provider. This value must match a provider name in Vagrant.
   * - ``provision``
     - Use to provision Vagrant when the instance is created. This is useful if the operating system needs customization during provisioning. Default value: ``false``.
   * - ``ssh_key``
     - Use to specify the private key file used for SSH authentication.
   * - ``synced_folders``
     - Use to specify a collection of synchronized folders on each Vagrant instance. Source paths are relative to the Kitchen root path. Default value: ``[]``. For example: ``synced_folders: - ["data/%{instance_name}", "/opt/instance_data"] - ["/host_path", "/vm_path", "create: true, type: :nfs"]``.
   * - ``vagrantfile_erb``
     - Use to specify an alternate Vagrant Embedded Ruby (ERB) template to be used by this driver.
   * - ``vagrantfiles``
     - An array of paths to one (or more) Vagrant files to be merged with the default Vagrant file. The paths may be absolute or relative to the .kitchen.yml file.
   * - ``vm_hostname``
     - Use to specify the internal hostname for the instance. This is not required when connecting to a Vagrant virtual machine. Set this to ``false`` to prevent this value from being rendered in the default Vagrantfile. Default value: computed from the platform name of the instance.

.. end_tag

.. tag test_kitchen_driver_vagrant_config

The ``kitchen-vagrant`` driver can predict the box name for Vagrant and the download URL that have been published by Chef. For example:

.. code-block:: ruby

   platforms:
   - name: ubuntu-14.04
   - name: ubuntu-16.04
   - name: centos-6
   - name: centos-7
   - name: debian-8

which will generate a configuration file similar to:

.. code-block:: ruby

   platforms:
   - name: ubuntu-14.04
     driver:
       box: bento/ubuntu-14.04
   - name: ubuntu-16.04
     driver:
       box: bento/ubuntu-16.04
   # ...

.. end_tag
