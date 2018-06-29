=====================================================
Chef Automate
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/chef_automate.rst>`__

.. tag chef_automate_mark

.. image:: ../../images/chef_automate_full.png
   :width: 40px
   :height: 17px

.. end_tag

Chef Automate provides a full suite of enterprise capabilities for workflow, node visibility and compliance.
Chef Automate integrates with the open-source products Chef, InSpec and Habitat. Chef Automate comes with
comprehensive 24×7 support services for the entire platform, including open source components.

.. image:: ../../images/automate_architecture.svg
   :width: 600px
   :align: center

Compliance
======================================================

Chef Automate 1.5.46 or later provides an easy way to view how successful the nodes in your infrastructure are at meeting the compliance requirements specified by your organization. Several built-in profiles are included in Chef Automate to scan for security risks, outdated software, and more. These profiles cover a variety of security frameworks, such as Center for Internet Security (CIS) benchmarks. If you have additional compliance requirements, you can also write your own compliance profiles in InSpec and upload them to Chef Automate. For more information how to view the compliance status across your cluster, see `Compliance Overview </chef_automate_compliance.html>`__.

.. tag EOL_compliance_server

.. warning:: The standalone Chef Compliance server is deprecated. The standalone Chef Compliance server's end-of-life date is December 31, 2018. `Chef Automate 2 <https://www.chef.io/automate/>`__ has all of the functionality of Chef Compliance Server and also includes newer out-of-the-box compliance profiles, an improved compliance scanner with total cloud scanning functionality, better visualizations, role-based access control and many other features not found in Chef Compliance Server. 

.. end_tag

If you are using an older version of Chef Automate, or your workflow requires you to use our standalone Chef Compliance server, you can find general information on Chef Compliance `here </chef_compliance.html>`__. 


Nodes
======================================================

Chef Automate gives you a data warehouse that accepts input from Chef, Habitat, and Chef Automate
workflow and compliance. It provides views into operational, compliance, and workflow events. There is a query
language available through the UI and customizable dashboards. For more information, see `Nodes Overview </visibility.html>`__.

Workflow
======================================================

Chef Automate includes a pipeline for continuous delivery of infrastructure and applications.
This full-stack approach, where infrastructure changes are delivered in tandem with any application changes,
allows for safe deployment at high velocity. For information Chef Automate safely moves changes move through a gated pipeline,
see `Workflow Overview </workflow.html>`__.
