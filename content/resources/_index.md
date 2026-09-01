+++
title = "Supported resources"
draft = false
description = "Unified reference of every resource available in Chef Infra Client and Chef InSpec, with a compatibility matrix and links to each product's documentation."
gh_repo = "chef-web-docs"
layout = "resources_matrix"
data_path = ["client", "19", "resources"]

swiftype_search_products = ["client", "inspec"]

[menu]
  [menu.overview]
    title = "Supported resources"
    identifier = "overview/packages_&_platforms/resources.md Supported resources"
    parent = "overview/packages_&_platforms"
    weight = 30
+++

Chef Infra Client and Chef InSpec both use _resources_ as their core building block, but for
different purposes. A Chef Infra Client resource declares the desired state of part of a system---a
package, service, file, or user---and Chef Infra Client configures the system to match.
A Chef InSpec resource inspects part of a system so you can write compliance and security tests
for its actual state.

This page is the single catalog of every resource across both products. Use it to discover which
resources exist, see at a glance whether a resource is available in Chef Infra Client,
Chef InSpec, or both, and go to each product's authoritative documentation.

For the resources introduced in a specific release, see that version's documentation. This page
lists the complete catalog and doesn't replace the version-specific resource references:

- [Chef Infra Client resources](/client/19/resources/)
- [Chef InSpec resources](/inspec/resources/)

The following sections list the resources supported by both products, then the complete catalog,
and finally the Chef InSpec resource packs. As of Chef InSpec 7, cloud and platform resources---such
as those for Amazon Web Services, Microsoft Azure, and Google Cloud Platform---moved out of
Chef InSpec core into separate resource packs, so this page groups them by pack rather than listing
each resource individually.
