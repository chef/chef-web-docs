=====================================================
Release Notes: chef-client 12.12
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

What's New
=====================================================
The following items are new for chef-client 12.12 and/or are changes from previous versions. The short version:

* **New node attribute APIs** Common set of methods to read, write, delete, and check if node attributes exist.
* **Data collector updates** Minor enhancements to data that the data collector reports on.
* **knife cookbook create has been deprecated** You should use `chef generate cookbook <https://docs.chef.io/ctl_chef.html#chef-generate-cookbook>`_ instead.

New node attribute read, write, unlink, and exist? APIs
-----------------------------------------------------------
The four methods ``read``, ``write``, ``unlink``, and ``exist?`` (and their corresponding unsafe versions) can be used on node objects to set, retrieve, delete, and validate existance of attributes.

read/read!
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Use the ``read`` method to retrieve an attribute value on a node object. It is a safe, non-autovivifying reader that returns ``nil`` if the attribute does not exist.  

``node.read("foo", "bar", "baz")`` is equivalent to ``node["foo"]["bar"]["baz"]`` but returns ``nil`` instead of raising an exception when no value is set.

The ``read!`` method is a non-autovivifying reader that also retrieves an attribute value on a node object; however, it will throw a NoMethodError exception if the attribute does not exist.

On the node level, ``node.default.read/read!("foo")`` behaves similarly to ``node.read("foo")``, but only on the default level.

write/write!
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Use the ``write`` method set an attribute value on a node object. It is a safe, autovivifying writer that replaces intermediate non-hash objects.

``node.write(:default, "foo", "bar", "baz")`` is equivalent to ``node.default["foo"]["bar"] = "baz"``.

The ``write!`` method is also an autovivifying method to set an attribute value on a node object; however, it will throw an NoSuchAttribute exception if there is a non-hash on an intermediate key.

.. note:: There is currently no non-autovivifying writer method for attributes.

On the node level, ``node.default.write/write!("foo", "bar")`` is equivalent to ``node.write/write!(:default, "foo", "bar")``.

unlink/unlink!
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Use the ``unlink`` method to delete an attribute on a node object. ``nil`` will be returned if the value is not a valid Hash or Array.

The ``unlink!`` method also deletes an attribute on a node object; however, it will throw a NoSuchAttribute exception if the attribute does not exist.

On the node level, ``node.default.unlink/unlink!("foo")`` is equivalent to ``node.unlink/unlink!(:default, "foo")``.

exist?
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Use the ``exist?`` method to check whether the attribute exists. For example, ``node.exist?("foo", "bar")`` can be used to see if ``node["foo"]["bar"]`` exists.

On the node level, ``node.default.exist?("foo", "bar")`` can be used to see if ``node.default["foo"]["bar"]`` exists.

Depreciated node attribute methods
--------------------------------------------------------
The following methods have been deprecated in this release:

* ``node.set``
* ``node.set_unless``

data_collector updates
-----------------------------------------------------
* Adds ``node`` to the data_collector message.
* ``data_collector`` reports on all resources and not just those that have been processed.


Changelog
=====================================================
https://github.com/chef/chef/blob/master/CHANGELOG.md
