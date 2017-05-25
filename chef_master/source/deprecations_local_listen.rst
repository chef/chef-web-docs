=======================================================
Deprecation: Local Mode Listen (CHEF-18)
=======================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/deprecations_local_listen.rst>`__

When using `chef-client` Local Mode, there are two ways to launch the internal
Chef Zero server. Originally we launched it as a normal network service on
localhost and then connected to it as per normal. Unfortunately this meant that
any user or process on the machine could also connect to the Zero server during
the converge and because Chef Zero has no authentication or authorization systems,
they could potentially alter data mid-converge. We later added a "socketless"
mode, which runs the Zero server completely internally and never exposes it on
a real socket.

This is more secure and safe in most situations, but some users of chef-provisioning,
specifically those using the Zero tunnel mode, need the socket mode as they
expose that out to clients via an SSH tunnel.

Remediation
===============

If you need to re-enable socket mode for now, you can run `chef-client --local-mode --listen`
or set `knife[:listen] = true` in your `.chef/knife.rb` or `.chef/config.rb`.
