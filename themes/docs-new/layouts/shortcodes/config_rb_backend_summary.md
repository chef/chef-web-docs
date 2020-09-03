The `chef-backend.rb` file is generated using
`chef-backend-ctl gen-sample-backend-config` and controls most of the
various feature and configuration flags going into a Chef HA backend
node. A number of these options control the reliability, stability and
uptime of the backend PostgreSQL databases, the elastic search index,
and the leader election system. Please refrain from changing them unless
you have been advised to do so.


-   `fqdn` Host name of this node.
-   `hide_sensitive` Set to `false` if you wish to print deltas of
    sensitive files and templates during `chef-backend-ctl reconfigure`
    runs. `true` by default.
-   `ip_version` Set to either `'ipv4'` or `'ipv6'`. `'ipv4'` by
    default.
-   `publish_address` Externally resolvable IP address of this back-end
    node.
