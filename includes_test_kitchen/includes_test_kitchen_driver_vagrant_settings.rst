.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following attributes are used to configure ``kitchen-vagrant`` for |chef|:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Attribute
     - Description
   * - ``box``
     - Required. Use to specify the box on which |vagrant| will run. Default value: computed from the platform name of the instance.
   * - ``box_check_update``
     - Use to check for box updates. Default value: ``false``. 
   * - ``box_url``
     - Use to specify the URL at which the configured box is located. Default value: computed from the platform name of the instance, but only when the |vagrant| provider is |virtualbox|- or |vmware|-based.
   * - ``communicator``
     - Use to override the ``config.vm.communicator`` setting in |vagrant|. For example, when a base box is a |windows| operating system that does not have |ssh| installed and enabled, |vagrant| will not be able to boot without a custom |vagrant| file. Default value: ``nil`` (assumes |ssh| is available).
   * - ``customize``
     - A hash of key-value pairs that define customizations that should be made to the |vagrant| virtual machine. For example: ``customize: memory: 1024 cpuexecutioncap: 50``.
   * - ``guest``
     - Use to specify the ``config.vm.guest`` setting in the default |vagrantfile|.
   * - ``gui``
     - Use to enable the graphical user interface for the defined platform. This is passed to the ``config.vm.provider`` setting in |vagrant|, but only when the |vagrant| provider is |virtualbox|- or |vmware|-based.
   * - ``network``
     - Use to specify an array of network customizations to be applied to the virtual machine. Default value: ``[]``. For example: ``network: - ["forwarded_port", {guest: 80, host: 8080}] - ["private_network", {ip: "192.168.33.33"}]``.
   * - ``pre_create_command``
     - Use to run a command immediately prior to ``vagrant up --no-provisioner``.
   * - ``provider``
     - Use to specify the |vagrant| provider. This value must match a provider name in |vagrant|.
   * - ``provision``
     - Use to provision |vagrant| when the instance is created. This is useful if the operating system needs customization during provisioning. Default value: ``false``.
   * - ``ssh_key``
     - Use to specify the private key file used for |ssh| authentication.
   * - ``synced_folders``
     - Use to specify a collection of synchronized folders on each |vagrant| instance. Source paths are relative to the |kitchen| root path. Default value: ``[]``. For example: ``synced_folders: - ["data/%{instance_name}", "/opt/instance_data"] - ["/host_path", "/vm_path", "create: true, type: :nfs"]``.
   * - ``vagrantfile_erb``
     - Use to specify an alternate |vagrant| |erb| template to be used by this driver.
   * - ``vagrantfiles``
     - An array of paths to one (or more) |vagrant| files to be merged with the default |vagrant| file. The paths may be absolute or relative to the |kitchen yml| file.
   * - ``vm_hostname``
     - Use to specify the internal hostname for the instance. This is not required when connecting to a |vagrant| virtual machine. Set this to ``false`` to prevent this value from being rendered in the default |vagrantfile|. Default value: computed from the platform name of the instance.
