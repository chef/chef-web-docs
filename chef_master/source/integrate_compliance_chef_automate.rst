=====================================================
Compliance scanning with Chef Automate
=====================================================

.. tag chef_automate_mark

.. image:: ../../images/chef_automate_full.png
   :width: 40px
   :height: 17px

.. end_tag

This page describes how to run compliance scanning when using Chef Automate:

To make it easy to retrieve profiles, execute and report results via chef converges, we created the ``audit`` cookbook. It's available in the Chef Supermarket or as a public GitHub `repo <https://github.com/chef-cookbooks/audit>`_. The cookbook depends on ``InSpec`` and uses attributes to support a few different ways of retrieving profiles and reporting the scan results:

Collector: ``chef-visibility``
=====================================================

This method is compatible with Chef Server managed nodes or Chef Solo (commonly referred to as "Chef client local mode")

When setting the ``node['audit]['collector']`` attribute to ``chef-visibility``, the ``audit`` cookbook can retrieve profiles from the following sources: ``Chef Supermarket``, ``local filesystem`` and ``git repository``.

The profiles execution result will be sent to Chef Automate(Visibility) using the ``data_collector`` url and ``token``. For more details, see the README file of the `audit <https://github.com/chef-cookbooks/audit>` cookbook.

Collector: ``chef-compliance``
=====================================================

This method is compatible with Chef Server managed nodes or Chef Solo.

When setting the ``node['audit]['collector']`` attribute to ``chef-compliance``, the ``audit`` cookbook can retrieve profiles from the following sources: ``Chef Compliance server``, ``Chef Supermarket``, ``local filesystem`` and ``git repository``.

The profiles execution result will be sent to Chef Compliance. Attributes to specify the Chef Compliance API sever and authentication token are required. For more details, see the README file of the `audit <https://github.com/chef-cookbooks/audit>` cookbook.

Collector: ``chef-server``
=====================================================

This method is compatible with nodes managed by a Chef Server integrated with `Chef Compliance <https://docs.chef.io/compliance.html>`_.

Integration instructions can be found `here
<https://docs.chef.io/integrate_compliance_chef_server.html>`_.

Integrate Chef Compliance with Chef Server to allow:

* Users of Chef Compliance to log in using their Chef Server credentials

* Nodes under management by Chef to download Chef Compliance profiles, run them on nodes, and then send the results back to Chef Compliance

When setting the ``node['audit]['collector']`` attribute to ``chef-server``, the ``audit`` cookbook can retrieve profiles from the following sources: ``Chef Compliance server``, ``Chef Supermarket``, ``local filesystem`` and ``git repository``.

The profiles execution result will be sent to Chef Compliance. For more details, see the README file of the `audit <https://github.com/chef-cookbooks/audit>` cookbook.

No Chef Compliance url or token attributes are required by this setup as Chef Server is acting as a proxy.
