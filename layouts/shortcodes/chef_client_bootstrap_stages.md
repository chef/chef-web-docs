The following diagram shows the stages of the bootstrap operation, and
the list below the diagram describes each of those stages in greater
detail.

![image](/images/chef_bootstrap.png)

During a `knife bootstrap` bootstrap operation, the following happens:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Stages</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>$ knife bootstrap</strong></td>
<td>Enter the <code>knife bootstrap</code> subcommand from a workstation. Include the hostname, IP address, or FQDN of the target node as part of this command. Knife will establish an SSH or WinRM connection with the target node using port 22 and assemble a shell script using the chef-full.erb file, which is the default bootstrap template.</td>
</tr>
<tr class="even">
<td><p><strong>Get the install script from Chef</strong></p></td>
<td><p>The shell script that is derived from the chef-full.erb bootstrap template will make a request to the Chef website to get the most recent version of a second shell script (<code>install.sh</code>).</p>
<p>On Microsoft Windows machines: The batch file that is derived from the windows-chef-client-msi.erb bootstrap template will make a request to the Chef website to get the .msi installer.</p></td>
</tr>
<tr class="odd">
<td><strong>Get the Chef Infra Client package from Chef</strong></td>
<td>The second shell script (or batch file) then gathers system-specific information and determines the correct package for Chef Infra Client, and then downloads the appropriate package from <code>omnitruck-direct.chef.io</code>.</td>
</tr>
<tr class="even">
<td><strong>Install Chef Infra Client</strong></td>
<td>Chef Infra Client is installed on the target node.</td>
</tr>
<tr class="odd">
<td><p><strong>Start a Chef Infra Client run</strong></p></td>
<td><p>On UNIX- and Linux-based machines: The second shell script executes the <code>chef-client</code> binary with a set of initial settings stored within <code>first-boot.json</code> on the node. <code>first-boot.json</code> is generated from the workstation as part of the initial <code>knife bootstrap</code> subcommand.</p>
<p>On Microsoft Windows machines: The batch file that is derived from the windows-chef-client-msi.erb bootstrap template executes the <code>chef-client</code> binary with a set of initial settings stored within <code>first-boot.json</code> on the node. <code>first-boot.json</code> is generated from the workstation as part of the initial <code>knife bootstrap</code> subcommand.</p></td>
</tr>
<tr class="even">
<td><p><strong>Complete a Chef Infra Client run</strong></p></td>
<td><p>a Chef Infra Client run proceeds, using HTTPS (port 443), and registers the node with the Chef Infra Server.</p>
<p>The first Chef Infra Client run, by default, contains an empty run-list. A <a href="/knife_bootstrap/">run-list can be specified</a> as part of the initial bootstrap operation using the <code>--run-list</code> option as part of the <code>knife bootstrap</code> subcommand.</p></td>
</tr>
</tbody>
</table>