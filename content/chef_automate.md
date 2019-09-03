+++
title = "Chef Automate"
draft = false

aliases = "/chef_automate.html"

[menu]
  [menu.docs]
    title = "Chef Automate Overview"
    identifier = "legacy/chef_automate_1/overview/chef_automate.md Chef Automate Overview"
    parent = "legacy/chef_automate_1/overview"
    weight = 10
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/chef_automate.rst)

<meta name="robots" content="noindex">

{{% chef_automate_mark %}}

{{% EOL_a1 %}}

Chef Automate provides a full suite of enterprise capabilities for
workflow, node visibility and compliance. Chef Automate integrates with
the open-source products Chef Server, Chef InSpec, and Chef Habitat.
Chef Automate comes with comprehensive 24×7 support services for the
entire platform, including open source components.

<img src="/images/automate_architecture.svg" class="align-center" width="600" alt="image" />

Compliance
==========

Chef Automate 1.5.46 or later provides an easy way to view how
successful the nodes in your infrastructure are at meeting the
compliance requirements specified by your organization. Several built-in
profiles are included in Chef Automate to scan for security risks,
outdated software, and more. These profiles cover a variety of security
frameworks, such as Center for Internet Security (CIS) benchmarks. If
you have additional compliance requirements, you can also write your own
compliance profiles in Chef InSpec and upload them to Chef Automate. For
more information how to view the compliance status across your cluster,
see [Compliance Overview](/chef_automate_compliance/).

{{% EOL_compliance_server %}}

If you are using an older version of Chef Automate, or your workflow
requires you to use our standalone Chef Compliance server, you can find
general information on Chef Compliance [here](/chef_compliance/).

Nodes
=====

Chef Automate gives you a data warehouse that accepts input from Chef
Server, Chef Habitat, and Chef Automate workflow and compliance. It
provides views into operational, compliance, and workflow events. There
is a query language available through the UI and customizable
dashboards. For more information, see [Nodes
Overview](/visibility/).

Workflow
========

Chef Automate includes a pipeline for continuous delivery of
infrastructure and applications. This full-stack approach, where
infrastructure changes are delivered in tandem with any application
changes, allows for safe deployment at high velocity. For information
Chef Automate safely moves changes move through a gated pipeline, see
[Workflow Overview](/workflow/).
