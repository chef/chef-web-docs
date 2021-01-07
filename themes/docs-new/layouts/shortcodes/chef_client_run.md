A "Chef Infra Client run" is the term used to describe the steps Chef Infra Client takes to configure a node when the chef-client command is run. The following diagram shows the various stages that occur during a Chef Infra Client run.

![image](/images/chef_run.png)

During every Chef Infra Client run, the following happens:

<table>
  <caption>
    Chef Client Run
  </caption>
  <col>
  <col>
  <colgroup span="3"></colgroup>
  <thead style="border-bottom: 1px solid lightgray;">
    <tr>
      <th scope="col">Phase</th>
      <th scope="col">Stage</th>
      <th scope="col">Description</th>
     </tr>
  </thead>
  <tbody style="border: 1px solid lightgray;">
    <tr>
      <th rowspan="8" scope="rowgroup" style="border-right: 1px solid lightgray; border-bottom: 1px solid lightgray;">Compile</th>
      <th scope="row">Get configuration data</th>
      <td>Chef Infra Client gets process configuration data from the <a href="/config_rb_client/">client.rb</a> file on the <a href="/nodes/">node</a>, and then gets node configuration data from Ohai. One important piece of configuration data is the name of the node, which is found in the <code>node_name</code> attribute in the client.rb file or is provided by Ohai. If Ohai provides the name of a node, it is typically the FQDN for the node, which is always unique within an organization.</td>
    </tr>
    <tr>
      <th scope="row">Authenticate to the Chef Infra Server</th>
      <td>Chef Infra Client <a href="/auth/">authenticates</a> to the Chef Infra Server using an RSA private key and the Chef Infra Server API. The name of the node is required as part of the authentication process to the Chef Infra Server. If this is the first Chef Infra Client run for a node, the chef-validator will be used to generate the RSA private key.</td>
    </tr>
    <tr>
      <th scope="row">Get, rebuild the node object</th>
      <td>Chef Infra Client pulls down the node object from the Chef Infra Server and then rebuilds it. A node object is made up of the system attributes discovered by Ohai, the attributes set in Policyfiles or Cookbooks, and the run list of cookbooks. The first time Chef Infra Client runs on a node, it creates a node object from the the default run-list. A node that has not yet had a Chef Infra Client run will not have a node object or a Chef Infra Server entry for a node object. On any subsequent Chef Infra Client runs, the rebuilt node object will also contain the run-list from the previous Chef Infra Client run.</td>
    </tr>
    <tr>
      <th scope="row">Expand the run-list</th>
      <td>Chef Infra Client expands the <a href="/run_lists/">run-list</a> from the rebuilt node object and compiles a complete list of recipes in the exact order that they will be applied to the node.</td>
    </tr>
    <tr>
      <th scope="row">Synchronize cookbooks</th>
      <td>Chef Infra Client requests all off the <a href="/cookbooks/">cookbook files</a> (including recipes, templates, resources, providers, attributes, and libraries) that it needs for every action identified in the run-list from the Chef Infra Server. The Chef Infra Server responds to Chef Infra Client with the complete list of files. Chef Infra Client compares the list of files to the files that already exist on the node from previous runs, and then downloads a copy of every new or modified file from the Chef Infra Server.</td>
    </tr>
    <tr>
      <th scope="row">Reset node attributes</th>
      <td>All attributes in the rebuilt node object are reset. All attributes from attribute files, Policyfiles, and Ohai are loaded. Attributes that are defined in attribute files are first loaded according to cookbook order. For each cookbook, attributes in the <code>default.rb</code> file are loaded first, and then additional attribute files (if present) are loaded in lexical sort order. If attribute files are found within any cookbooks that are listed as dependencies in the <code>metadata.rb</code> file, these are loaded as well. All attributes in the rebuilt node object are updated with the attribute data according to attribute precedence. When all of the attributes are updated, the rebuilt node object is complete.</td>
    </tr>
    <tr style="border-bottom: 1px solid lightgray;">
      <th scope="row">Compile the resource collection</th>
      <td>Chef Infra Client identifies each resource in the node object and builds the resource collection. Libraries are loaded first to ensure that all language extensions and Ruby classes are available to all resources. Next, attributes are loaded, followed by custom resources. Finally, all recipes are loaded in the order specified by the expanded run-list. This is also referred to as the "compile phase".
    </tr>
  </tr>
  <tr>
    <tr>
      <th rowspan="3" scope="rowgroup" style="border-right: 1px solid lightgray; border-bottom: 1px solid lightgray;">Converge</th>
      <th>Converge the node</th>
      <td>Chef Infra Client configures the system based on the information that has been collected. Each resource is executed in the order identified by the run-list, and then by the order in which each resource is listed in each recipe. Each resource defines an action to run, which configures a specific part of the system. This process is also referred to as convergence. This is also referred to as the "execution phase".</td>
    </tr>
    <tr style="border-bottom: 1px solid lightgray;">
      <th scope="row">Update the node object, process exception and report handlers</th>
      <td><p>When all of the actions identified by resources in the resource collection have been done and Chef Infra Client finishes successfully, then Chef Infra Client updates the node object on the Chef Infra Server with the node object built during a Chef Infra Client run. (This node object will be pulled down by Chef Infra Client during the next Chef Infra Client run.) This makes the node object (and the data in the node object) available for search.</p>
      <p>Chef Infra Client always checks the resource collection for the presence of exception and report handlers. If any are present, each one is processed appropriately.</p></td>
    </tr>
  </tr>
  <tr>
    <tr>
      <th rowspan="3" scope="rowgroup" style="border-right: 1px solid lightgray;">Compliance</th>
      <th>Get, run Chef InSpec compliance profiles</th>
      <td>If one or more Chef InSpec profiles are specified in the node object, then Chef Infra Client downloads these InSpec profiles from sources like Chef Automate, Chef Supermarket, or GitHub. During the Chef Infra Client compliance phase, the chef-client calls on Chef InSpec to detect violations of the profiles. Chef InSpec works by comparing the node object with with the desired state in Chef InSpec compliance profiles.</td>
    </tr>
    <tr scope="row">
      <th>Send the compliance report</th>
      <td> After each Chef InSpec scan, the chef-client sends the results to Chef Automate or saves the results locally.</td>
    </tr>
  </tr>
  <th scope="row">Stop, wait for the next run</th>
  <td>When everything is configured and the Chef Infra Client run is complete, Chef Infra Client stops and waits until the next time it is asked to run.</td>
  </tr>
</tbody>
</table>
