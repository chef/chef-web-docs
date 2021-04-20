+++
title = "Chef Infra Client Overview"
draft = false

gh_repo = "chef-web-docs"

aliases = ["/chef_client_overview.html", "/chef_client.html"]

[menu]
  [menu.infra]
    title = "Chef Infra Client Overview"
    identifier = "chef_infra/concepts/chef_client_overview.md Chef Infra Client Overview"
    parent = "chef_infra/concepts"
    weight = 10
+++

{{< note >}}

For the `chef-client` command line tool, see
[chef-client(executable)](/ctl_chef_client/).

{{< /note >}}

<!-- markdownlint-disable MD033 -->
<table>
<colgroup>
<col style="width: 19%" />
<col style="width: 80%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><img src="/images/icon_chef_client.svg" class="align-center" width="100" alt="image" /></p></td>
<td><p>{{< readFile_shortcode file="chef_client_summary.md" >}}</p>
<p>{{< readFile_shortcode file="security_key_pairs_chef_client.md" >}}</p></td>
</tr>
</tbody>
</table>

<!-- markdownlint-enable MD033 -->

## Important Terms
<!-- `chef` entry is temporary. Using to clarify terms -->

agent
: Agents are programs that you configure to perform actions continuously and autonomously.

chef
: `chef` is the Chef Workstation command line tool for managing your Chef development environment including repositories, cookbooks, recipes, attributes, templates, custom resources, and Ruby dependencies.

chef-client
: The `chef-client` is an agent that runs on nodes and a command line tool that runs on your local computer. The `chef-client` allows you to ensure the configuration of your systems through policy code. You install the chef-client on to nodes with the bootstrap process from your computer and configure it to run on an interval to ensure configuration compliance. You use the chef-client command line tool from your workstation to send instructions to the agent.

knife
: A command-line tool that provides an interface between a local chef-repo and the Chef Infra Server. Use it to manage nodes, cookbooks, recipes, roles, data bags, environments, bootstrapping nodes, searching the Chef Infra Server, and more.

Ohai
: Ohai is a tool that is used to detect attributes on a node, and then provide these attributes to Chef Infra Client at the start of every run.

## Basic Chef Topology

You are here: Workstation - Node - Server

Consider a triangle with chef-client in the middle. Specify that it is automated.
The chef-client run on an interval to ensure that running nodes are configured correctly. It has four stages:

Give an easy-to-understand explanation and give more depth in the next section.
Compile
Converge
Compliance
Complete

## The Chef Infra Client Run

{{% chef_client_run %}}

## Related Content

- [Chef Infra Client (executable)](/ctl_chef_client/)
- [Chef Infra Server](/server/)
- [Cookbooks](/cookbooks/)
- [Nodes](/nodes/)
- [Run Lists](/run_lists/)

## Next Steps

- [Install Chef Workstation](/workstation/install_workstation/)
- [Bootstrap Nodes](/install_bootstrap/)
