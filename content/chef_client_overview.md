+++
title = "Chef Infra Client Overview"
draft = false

gh_repo = "chef-web-docs"

aliases = ["/chef_client_overview.html", "/chef_client.html", "/essentials_nodes_chef_run.html"]

[menu]
  [menu.infra]
    title = "Chef Infra Client Overview"
    identifier = "chef_infra/overview/chef_client_overview.md Chef Infra Client Overview"
    parent = "chef_infra/overview"
    weight = 20
+++

{{< note >}}

For the `chef-client` command line tool, see
[chef-client(executable)](/ctl_chef_client/).

{{< /note >}}

<!-- markdownlint-disable MD036-->
**New in Chef Infra Client 17**
<!-- markdownlint-enable MD036-->

Chef Infra Client's Compliance Phase lets you automatically execute compliance audits and view the results as part of any Chef Infra Client Run. The Compliance Phase replaces the legacy audit cookbook and works with your existing audit cookbook attributes. You can also set up the Compliance Phase for new cookbooks. See [Compliance Phase]({{< relref "chef_compliance_phase" >}}) documentation to upgrade.

<!-- markdownlint-disable MD033 -->
<table>
<colgroup>
<col style="width: 19%" />
<col style="width: 80%" />
</colgroup>
<tbody>
<tr>
<td><p><img src="/images/icon_chef_client.svg" class="align-center" width="130" alt="image" /></p></td>
<td><p>{{< readFile_shortcode file="chef_client_summary.md" >}}</p>
<p>{{< readFile_shortcode file="security_key_pairs_chef_client.md" >}}</p></td>
</tr>
</tbody>
</table>

<!-- markdownlint-enable MD033 -->

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
