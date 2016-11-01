=====================================================
Release Notes: chef-client 11.4
=====================================================

.. tag chef

Chef is a powerful automation platform that transforms infrastructure into code. Whether you’re operating in the cloud, on-premises, or in a hybrid environment, Chef automates how infrastructure is configured, deployed, and managed across your network, no matter its size.

This diagram shows how you develop, test, and deploy your Chef code.

.. image:: ../../images/start_chef.svg
   :width: 700px
   :align: center

.. end_tag

What's Fixed
=====================================================
The following bugs were fixed:

* `CHEF-3432 <http://tickets.opscode.com/browse/CHEF-3432>`_  --- chef-client using lots of memory
* `CHEF-4117 <http://tickets.opscode.com/browse/CHEF-4117>`_  --- LWRP resource removal does not restrict constant lookup namespace

What's Improved
=====================================================
The following improvements were made:

* `CHEF-3367 <http://tickets.opscode.com/browse/CHEF-3367>`_  --- chef-client daemon's pid file is sometimes accidentally removed

