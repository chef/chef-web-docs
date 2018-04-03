=====================================================
macos_userdefaults
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_macos_userdefaults.rst>`__

Use the **macos_userdefaults** resource to manage the macOS `user defaults <https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/UserDefaults/AboutPreferenceDomains/AboutPreferenceDomains.html#//apple_ref/doc/uid/10000059i-CH2-SW6>`__ system. The properties of the resource are passed to the ``defaults`` command, and the parameters follow the conventions of that command. See the ``defaults`` man page for additional information.

**New in Chef Client 14.0.**

Syntax
=====================================================
This resource has the following Syntax:

.. code-block:: ruby

   macos_userdefaults 'name' do
     domain                String # required
     global                True, False # default value: 'false'
     key                   String
     sudo                  True, False # default value: 'false'
     type                  String # default value: ""
     user                  String
     value                 # required - see description
     action                Symbol # default to :write if not specified

where:

* ``macos_userdefaults`` is the name of the resource
* ``'name'`` is the name of the resource block
* ``action`` identifies the steps the chef-client will take to bring the node to the desired state
* ``domain``, ``global``, ``key``, ``sudo``, ``type``, ``user``, and ``value`` are the properties available to this resource

Actions
=====================================================
This resource has the following actions:

``:write``
   Default. Writes the setting to the specified domain. 

``:nothing``
   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, the resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

Properties
=====================================================
This resource has the following properties:

``domain``
   **Ruby Type:** String

   Required. The domain that the user defaults belong to. 

``global``
   **Ruby Types:** True, False | **Default Value:** ``false``

   Determines whether or not the domain is `global <https://developer.apple.com/documentation/foundation/nsglobaldomain>`__.

``key``
   **Ruby Type:** String

   The preference key. 

``sudo``
   **Ruby Types:** True, False | **Default Value:** ``false``

   Set to ``true`` if the setting you wish to modify requires privileged access.

``type``
   **Ruby Type:** String | **Default Value:** ``""``

   The value type of the preference key.

``user``
   **Ruby Type:** String

   The system user that the default will be applied to. 

``value``
   **Ruby Types:** Integer, Float, String, TrueClass, FalseClass, Hash, Array
   
   Required. The value of the key. 


Examples
=====================================================
**Specify a global domain**

.. code-block:: ruby

   macos_userdefaults 'full keyboard access to all controls' do
     domain 'AppleKeyboardUIMode'
     global true
     value '2'
   end

**Use an integer value**

.. code-block:: ruby

   macos_userdefaults 'enable macOS firewall' do
     domain '/Library/Preferences/com.apple.alf'
     key 'globalstate'
     value '1'
     type 'int'
   end

**Use a boolean value**

.. code-block:: ruby

   macos_userdefaults 'finder expanded save dialogs' do
     domain 'NSNavPanelExpandedStateForSaveMode'
     global true
     value 'TRUE'
     type 'bool'
   end