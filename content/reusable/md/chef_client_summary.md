Chef Infra Client is an agent that runs locally on every node that is under management by Chef Infra Server. When Chef Infra Client runs, it performs all of the steps required for bringing a node into the expected state, including:

- Registering and authenticating the node with Chef Infra Server
- Synchronizing cookbooks from the Chef Infra Server to the node
- Compiling the resource collection by loading each of the required cookbooks, including recipes, attributes, and all other dependencies
- Taking the appropriate and required actions to configure the node based on recipes and attributes
- Reporting summary information on the run to Chef Automate