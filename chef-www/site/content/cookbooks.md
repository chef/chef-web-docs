+++
title = "About Cookbooks"
description = "DESCRIPTION"
draft = false

aliases = "/cookbooks.html"

[menu]
  [menu.docs]
    title = "Cookbooks"
    identifier = "cookbooks/cookbooks.html"
    parent = "chef infra/concepts"
    weight = 60
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/cookbooks.rst)

{{% cookbooks_summary %}}

Chef Infra Client uses Ruby as its reference language for creating
cookbooks and defining recipes, with an extended DSL for specific
resources. Chef Infra Client provides a reasonable set of resources,
enough to support many of the most common infrastructure automation
scenarios; however, this DSL can also be extended when additional
resources and capabilities are required.

Components
==========

Some important components of cookbooks include:

<table>
<colgroup>
<col style="width: 12%" />
<col style="width: 87%" />
</colgroup>
<thead>
<tr class="header">
<th>Feature</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><a href="/attributes.html">Attributes</a></td>
<td>{{% cookbooks_attribute %}}</td>
</tr>
<tr class="even">
<td><a href="/recipes.html">Recipes</a></td>
<td>{{% cookbooks_recipe %}}</td>
</tr>
</tbody>
</table>

Chef Infra Client will run a recipe only when asked. When Chef Infra
Client runs the same recipe more than once, the results will be the same
system state each time. When a recipe is run against a system, but
nothing has changed on either the system or in the recipe, Chef Infra
Client won't change anything.

In addition to attributes and recipes, the following items are also part
of cookbooks:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Components</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><a href="/files.html">Files</a></td>
<td>A file distribution is a specific type of resource that tells a cookbook how to distribute files, including by node, by platform, or by file version.</td>
</tr>
<tr class="even">
<td><a href="/libraries.html">Libraries</a></td>
<td>A library allows the use of arbitrary Ruby code in a cookbook, either as a way to extend the Chef Infra Client language or to implement a new class.</td>
</tr>
<tr class="odd">
<td><a href="/custom_resources.html">Custom Resources</a></td>
<td>A custom resource is an abstract approach for defining a set of actions and (for each action) a set of properties and validation parameters.</td>
</tr>
<tr class="even">
<td><a href="/cookbook_repo.html">Metadata</a></td>
<td>A metadata file is used to ensure that each cookbook is correctly deployed to each node.</td>
</tr>
<tr class="odd">
<td><a href="/resource.html">Resources</a></td>
<td>A resource instructs Chef Infra Client to complete various tasks like installing packages, running Ruby code, or accessing directories and file systems. Chef Infra Client includes built-in resources that cover many common scenarios. For the full list of resources that are built-in to Chef Infra Client, see our <a href="/resource_reference.html">Resources Reference</a>.</td>
</tr>
<tr class="even">
<td><a href="/templates.html">Templates</a></td>
<td>A template is a file written in markup language that uses Ruby statements to solve complex configuration scenarios.</td>
</tr>
<tr class="odd">
<td><a href="/cookbook_versioning.html">Cookbook Versioning</a></td>
<td>{{% cookbooks_version %}}</td>
</tr>
</tbody>
</table>

Community Cookbooks
===================

Chef maintains a large collection of cookbooks. In addition, there are
thousands of cookbooks created and maintained by the community:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Components</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><a href="https://github.com/chef-cookbooks">Cookbooks Maintained by Chef</a></td>
<td>Chef maintains a collection of cookbooks that are widely used by the community.</td>
</tr>
<tr class="even">
<td><a href="https://supermarket.chef.io/cookbooks">Cookbooks Maintained by the Community</a></td>
<td>The community has authored thousands of cookbooks, ranging from niche cookbooks that are used by only a few organizations to cookbooks that are some of the most popular and are used by nearly everyone.</td>
</tr>
</tbody>
</table>
