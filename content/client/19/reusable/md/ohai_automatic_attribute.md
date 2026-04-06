<!-- cspell:ignore ipaddress -->

An automatic attribute is a specific detail about a node, such as an IP address, a host name, or a list of loaded kernel modules.
Ohai detects automatic attributes and Chef Infra Client uses them to ensure that they're handled properly during every Chef Infra Client run.

The most commonly accessed automatic attributes are:

`node['platform']`
: The platform on which a node is running. This attribute helps determine which providers Chef Infra Client uses.

`node['platform_family']`
: The platform family is a Chef Infra specific grouping of similar platforms where cookbook code can often be shared. For example, `rhel` includes Red Hat Linux, Oracle Linux, CentOS, and several other platforms that are almost identical to Red Hat Linux.

`node['platform_version']`
: The version of the platform. This attribute helps determine which providers Chef Infra Client uses.

`node['ipaddress']`
: The IP address for a node. If the node has a default route, this is the IPv4 address for the interface. If the node doesn't have a default route, the value for this attribute should be `nil`. The IP address for the default route is the recommended default value.

`node['macaddress']`
: The MAC address for a node, determined by the same interface used to detect the `node['ipaddress']`.

`node['fqdn']`
: The fully qualified domain name for a node. Chef Infra Client uses this as the name of a node unless otherwise set.

`node['hostname']`
: The host name for the node.

`node['domain']`
: The domain for the node.

`node['recipes']`
: A list of recipes associated with a node (and part of that node's run-list).

`node['roles']`
: A list of roles associated with a node (and part of that node's run-list).

`node['ohai_time']`
: The time at which Ohai was last run. This attribute isn't commonly used in recipes, but it's saved to Chef Infra Server and can be accessed using the `knife status` subcommand.
