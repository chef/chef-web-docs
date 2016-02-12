.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


.. warning:: When these settings are used, any attribute not defined in a whitelist will not be saved. Each attribute type is whitelisted independently of the other attribute types. For example, if ``automatic_attribute_whitelist`` defines attributes to be saved, but ``normal_attribute_whitelist``, ``default_attribute_whitelist``, and ``override_attribute_whitelist`` are not defined, then all normal, default and override attributes are saved, along with only the specified automatic attributes.

Attributes that should be saved by a node may be whitelisted in the |client rb| file. The whitelist is a |ruby hash| of keys that specify each attribute to be saved. 

Attribute are whitelisted by attribute type, with each attribute type being whitelisted independently. Each attribute type---``automatic``, ``default``, ``normal``, and ``override``---may define whitelists by using the following settings in the |client rb| file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``automatic_attribute_whitelist``
     - |whitelist attribute_automatic| For example: ``['network/interfaces/eth0']``. Default value: all attributes are saved. |whitelist attribute_none|
   * - ``default_attribute_whitelist``
     - |whitelist attribute_default| For example: ``['filesystem/dev/disk0s2/size']``. Default value: all attributes are saved. |whitelist attribute_none|
   * - ``normal_attribute_whitelist``
     - |whitelist attribute_normal| For example: ``['filesystem/dev/disk0s2/size']``. Default value: all attributes are saved. |whitelist attribute_none|
   * - ``override_attribute_whitelist``
     - |whitelist attribute_override| For example: ``['map - autohome/size']``. Default value: all attributes are saved. |whitelist attribute_none|

.. warning:: It is recommended that only ``automatic_attribute_whitelist`` be used to whitelist attributes. This is primarily because automatic attributes generate the most data, but also that normal, default, and override attributes are typically much more important attributes and are more likely to cause issues if they are whitelisted incorrectly.

For example, normal attribute data similar to:

.. code-block:: javascript

   {
     "filesystem" => {
       "/dev/disk0s2" => {
         "size" => "10mb"
       },
       "map - autohome" => {
         "size" => "10mb"
       }
     },
     "network" => {
       "interfaces" => {
         "eth0" => {...},
         "eth1" => {...},
       }
     } 
   }

To whitelist the ``network`` attributes and prevent the other attributes from being saved, update the |client rb| file:

.. code-block:: ruby

   normal_attribute_whitelist ['network/interfaces/']

When a whitelist is defined, any attribute of that type that is not specified in that attribute whitelist **will not** be saved. So based on the previous whitelist for normal attributes, the ``filesystem`` and ``map - autohome`` attributes will not be saved, but the ``network`` attributes will.

Leave the value empty to prevent all attributes of that attribute type from being saved:

.. code-block:: ruby

   normal_attribute_whitelist []

For attributes that contain slashes (``/``) within the attribute value, such as the ``filesystem`` attribute ``'/dev/diskos2'``, use an array. For example:

.. code-block:: ruby

   automatic_attribute_whitelist [['filesystem','/dev/diskos2']]
