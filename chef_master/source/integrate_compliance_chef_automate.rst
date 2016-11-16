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

The profiles execution result will be sent to Chef Automate using the ``data_collector`` url and ``token``. For more details, see the README file of the `audit <https://github.com/chef-cookbooks/audit>` cookbook.

Collector: ``chef-compliance``
=====================================================

This method is compatible with Chef Server managed nodes or Chef Solo.

When setting the ``node['audit]['collector']`` attribute to ``chef-compliance``, the ``audit`` cookbook can retrieve profiles from the following sources: ``Chef Compliance server``, ``Chef Supermarket``, ``local filesystem`` and ``git repository``.

The profiles execution result will be sent to Chef Compliance. Attributes to specify the Chef Compliance API sever and authentication token are required. For more details, see the README file of the `audit <https://github.com/chef-cookbooks/audit>` cookbook.

Collector: ``chef-server-visibility``
=====================================================

This method is compatible with nodes managed by a Chef server integrated with Chef Automate and requires the following:

* Requires ``audit`` cookbook version 2.2.0 or newer.

* Requires Chef server version 12.11.0 or newer.

* Requires Chef Automate 0.6.0 or newer.

Using the above versions allows:

* Nodes under management by Chef to download compliance profiles from the Chef Automate asset store via Chef Server.

* Nodes under management by Chef to report converge and compliance scan results to Chef Automate(Visibility) via Chef Server.

To enable this use-case, add the following settings to ``/etc/opscode/chef-server.rb`` on the Chef server:

.. code-block:: bash

   data_collector['root_url'] = 'https://my-automate-server.mycompany.com/data-collector/v0/'
   data_collector['token'] = 'TOKEN'
   profiles['root_url'] = 'https://my-automate-server.mycompany.com'

and run ``sudo chef-server-ctl reconfigure``

The profiles store service also needs to be enabled in Chef Automate. This is documented in :ref:`profiles`.

When using the ``audit`` cookbook, set the ``node['audit]['collector']`` attribute to ``chef-server-visibility``, and retrieve profiles from the following sources: ``Chef Automate``(via ``Chef Server``), ``Chef Supermarket``, ``local filesystem`` and ``git repository``.

The profiles execution result will be sent to Chef Visibility. For more details, see the README file of the `audit <https://github.com/chef-cookbooks/audit>` cookbook.

The ``audit`` cookbook does not require Chef Automate url or token attributes as Chef Server is acting as a proxy in this setup.


Collector: ``chef-server``
=====================================================

This method is compatible with nodes managed by a Chef server integrated with :doc:`Chef Compliance </compliance>`.

Integration instructions can be found :doc:`here </integrate_compliance_chef_server>`.

Integrating Chef Compliance with Chef server allows:

* Users of Chef Compliance to log in using their Chef Server credentials

* Nodes under management by Chef to download Chef Compliance profiles, run them on nodes, and then send the results back to Chef Compliance

When setting the ``node['audit]['collector']`` attribute to ``chef-server``, the ``audit`` cookbook can retrieve profiles from the following sources: ``Chef Compliance server``, ``Chef Supermarket``, ``local filesystem`` and ``git repository``.

The profiles execution result will be sent to Chef Compliance. For more details, see the README file of the `audit <https://github.com/chef-cookbooks/audit>` cookbook.

No Chef Compliance url or token attributes are required by this setup as Chef Server is acting as a proxy.
