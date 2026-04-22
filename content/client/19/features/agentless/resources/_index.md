+++
title = "Supported Chef Infra resources in Agentless Mode"
linkTitle = "Supported resources"

[menu.client_19]
title = "Supported resources"
identifier = "features/agentless/resources/overview"
parent = "features/agentless/resources"
weight = 10
+++

<!-- markdownlint-disable MD059 -->

The following Chef Infra resources are supported in Agentless Mode.

| **Resources Name** | **Verified Platforms** | **Remarks** |
|---|---|---|
| [alternatives](/client/19/resources/bundled/alternatives/) | Ubuntu, Linux | |
| [apt_package](/client/19/resources/bundled/apt_package/) | Ubuntu | |
| [apt_preference](/client/19/resources/bundled/apt_preference/) | Ubuntu, Linux | |
| [apt_repository](/client/19/resources/bundled/apt_repository/) | Ubuntu, Linux | |
| [apt_update](/client/19/resources/bundled/apt_update/) | Ubuntu, Linux | |
| [bash](/client/19/resources/bundled/bash/) | Ubuntu, Linux, Solaris, Alpine, SUSE | |
| [breakpoint](/client/19/resources/bundled/breakpoint/) | Ubuntu, Linux | |
| [chef_acl](/client/19/resources/bundled/chef_acl/) | Ubuntu, Linux, CentOS 9 | |
| [chef_client](/client/19/resources/bundled/chef_client/) | Ubuntu 24.04, Linux Red Hat 9, Solaris, Alpine, SUSE | |
| [chef_client_config](/client/19/resources/bundled/chef_client_config/) | Ubuntu, Linux, Solaris, Alpine, SUSE | |
| [chef_container](/client/19/resources/bundled/chef_container/) | Ubuntu, Linux | |
| [chef_data_bag](/client/19/resources/bundled/chef_data_bag/) | Ubuntu, Linux | |
| [chef_environment](/client/19/resources/bundled/chef_environment/) | Ubuntu, Linux | |
| [chef_group](/client/19/resources/bundled/chef_group/) | Ubuntu 24.04 and 18.04, RHEL | |
| [chef_node](/client/19/resources/bundled/chef_node/) | Ubuntu 24.04, Linux Red Hat 9 | |
| [chef_organization](/client/19/resources/bundled/chef_organization/) | Ubuntu 24.04 and 18.04, RHEL | |
| [chef_role](/client/19/resources/bundled/chef_role/) | Ubuntu 24.04, Linux Red Hat 9, Solaris, Alpine, SUSE | |
| [chef_sleep](/client/19/resources/bundled/chef_sleep/) | Ubuntu, Linux | |
| [chef_user](/client/19/resources/bundled/chef_user/) | Ubuntu 24.04 and 18.04, RHEL, Solaris, Alpine, SUSE | |
| [cookbook_file](/client/19/resources/bundled/cookbook_file/) | Ubuntu, Linux, Solaris, Alpine, SUSE | |
| [cron](/client/19/resources/bundled/cron/) | Ubuntu, Linux, Solaris SunOS, Alpine | |
| [cron_access](/client/19/resources/bundled/cron_access/) | Ubuntu, Linux, Solaris SunOS, Alpine | |
| [cron_d](/client/19/resources/bundled/cron_d/) | Ubuntu, Linux | |
| [csh](/client/19/resources/bundled/csh/) | Ubuntu 24.04, Linux Red Hat 9, Alpine | |
| [directory](/client/19/resources/bundled/directory/) | Ubuntu, Linux, Solaris, Alpine, SUSE | |
| [execute](/client/19/resources/bundled/execute/) | Ubuntu, Linux, Solaris, Alpine, SUSE | |
| [file](/client/19/resources/bundled/file/) | Ubuntu, Linux, Solaris, Alpine, SUSE | |
| [freebsd_package](/client/19/resources/bundled/freebsd_package/) | FreeBSD 14 | Supported on FreeBSD. |
| [git](/client/19/resources/bundled/git/) | Ubuntu, Linux, Solaris, Alpine, SUSE | |
| [group](/client/19/resources/bundled/group/) | Ubuntu, Linux, Solaris, Alpine, SUSE | |
| [habitat_config](/client/19/resources/bundled/habitat_config/) | Ubuntu 24.04, Linux Red Hat 9, Solaris, Alpine, SUSE | |
| [habitat_install](/client/19/resources/bundled/habitat_install/) | Ubuntu, Linux, Solaris, Alpine, SUSE | |
| [habitat_package](/client/19/resources/bundled/habitat_package/) | Ubuntu, Linux, Solaris, Alpine, SUSE | |
| [habitat_service](/client/19/resources/bundled/habitat_service/) | Ubuntu, Linux | |
| [habitat_sup](/client/19/resources/bundled/habitat_sup/) | Ubuntu, Linux | |
| [hostname](/client/19/resources/bundled/hostname/) | Ubuntu, Linux | |
| [http_request](/client/19/resources/bundled/http_request/) | Ubuntu, Linux, , Solaris, Alpine, SUSE | |
| [ifconfig](/client/19/resources/bundled/ifconfig/) | Ubuntu, Linux | |
| [inspec_input](/client/19/resources/bundled/inspec_input/) | Ubuntu 24.04, Linux Red Hat 9 | |
| [inspec_waiver](/client/19/resources/bundled/inspec_waiver/) | Ubuntu, Linux | |
| [inspec_waiver_file_entry](/client/19/resources/bundled/inspec_waiver_file_entry/) | Ubuntu, Linux | |
| [kernel_module](/client/19/resources/bundled/kernel_module/) | Ubuntu, Linux | |
| [ksh](/client/19/resources/bundled/ksh/) | Ubuntu 24.04, Linux Red Hat 9, Solaris, Alpine, SUSE | |
| [link](/client/19/resources/bundled/link/) | Ubuntu, Linux, Solaris, Alpine, SUSE | |
| [locale](/client/19/resources/bundled/locale/) | Ubuntu | |
| [log](/client/19/resources/bundled/log/) | Ubuntu, Linux, Solaris, Alpine, SUSE | |
| [mount](/client/19/resources/bundled/mount/) | Ubuntu 24.04, CentOS 9 | |
| [notify_group](/client/19/resources/bundled/notify_group/) | Ubuntu, Linux | |
| [ohai](/client/19/resources/bundled/ohai/) | Ubuntu, Linux | |
| [ohai_hint](/client/19/resources/bundled/ohai_hint/) | Ubuntu, Linux | |
| [package](/client/19/resources/bundled/package/) | Ubuntu, Linux, CentOS 9, Solaris, Alpine, SUSE | |
| [perl](/client/19/resources/bundled/perl/) | Ubuntu | |
| [python](/client/19/resources/bundled/python/) | Ubuntu 24.04, Linux Red Hat 9, Solaris, Alpine, SUSE | |
| [reboot](/client/19/resources/bundled/reboot/) | Ubuntu, Linux | |
| [remote_file](/client/19/resources/bundled/remote_file/) | Ubuntu, Linux, CentOS 9, Solaris, Alpine, SUSE | |
| [rhsm_errata](/client/19/resources/bundled/rhsm_errata/) | Linux (redhat) | |
| [rhsm_errata_level](/client/19/resources/bundled/rhsm_errata_level/) | Linux (redhat) | |
| [rhsm_register](/client/19/resources/bundled/rhsm_register/) | Linux (redhat) | |
| [rhsm_repo](/client/19/resources/bundled/rhsm_repo/) | Linux (redhat) | |
| [rhsm_subscription](/client/19/resources/bundled/rhsm_subscription/) | Linux (redhat) | |
| [route](/client/19/resources/bundled/route/) | Ubuntu 24.04 / CentOS 9 | |
| [rpm_package](/client/19/resources/bundled/rpm_package/) | CentOS 9 | The RPM package must be locally available on the remote system. |
| [ruby_block](/client/19/resources/bundled/ruby_block/) | Ubuntu, Linux, CentOS 9 | |
| [script](/client/19/resources/bundled/script/) | Ubuntu 24.04, Linux Red Hat 9, , Solaris, Alpine | |
| [selinux_boolean](/client/19/resources/bundled/selinux_boolean/) | Ubuntu, Linux | |
| [selinux_fcontext](/client/19/resources/bundled/selinux_fcontext/) | Ubuntu, Linux | |
| [selinux_install](/client/19/resources/bundled/selinux_install/) | Ubuntu, Linux | |
| [selinux_login](/client/19/resources/bundled/selinux_login/) | Ubuntu, Linux | |
| [selinux_module](/client/19/resources/bundled/selinux_module/) | Ubuntu, Linux | |
| [selinux_permissive](/client/19/resources/bundled/selinux_permissive/) | Ubuntu, Linux | |
| [selinux_port](/client/19/resources/bundled/selinux_port/) | Ubuntu, Linux | |
| [selinux_state](/client/19/resources/bundled/selinux_state/) | Ubuntu, Linux | |
| [selinux_user](/client/19/resources/bundled/selinux_user/) | Ubuntu, Linux | |
| [service](/client/19/resources/bundled/service/) | Ubuntu, Linux, CentOS 9, Solaris, Alpine, SUSE | `crond` for Linux |
| [snap_package](/client/19/resources/bundled/snap_package/) | Ubuntu 24.04 | Supported on Linux. |
| [ssh_known_hosts_entry](/client/19/resources/bundled/ssh_known_hosts_entry/) | Ubuntu, Linux | |
| [subversion](/client/19/resources/bundled/subversion/) | Ubuntu 24.04, Linux Red Hat 9, CentOS 9 | The subversion resource has known bugs and may not work as expected. For more information, see the Chef GitHub issues [#4050](https://github.com/chef/chef/issues/4050) and [#4257](https://github.com/chef/chef/issues/4257). |
| [sudo](/client/19/resources/bundled/sudo/) | Ubuntu, Linux, CentOS 9, Solaris, Alpine, SUSE | |
| [swap_file](/client/19/resources/bundled/swap_file/) | Ubuntu, Linux | |
| [sysctl](/client/19/resources/bundled/sysctl/) | Ubuntu, Linux | |
| [systemd_unit](/client/19/resources/bundled/systemd_unit/) | Ubuntu, Linux | |
| [template](/client/19/resources/bundled/template/) | Ubuntu, Linux, CentOS 9, Solaris, Alpine, SUSE | Require absolute path for source attribute. |
| [timezone](/client/19/resources/bundled/timezone/) | Linux, Solaris, Alpine, SUSE | |
| [user](/client/19/resources/bundled/user/) | Ubuntu, Linux | |
| [user_ulimit](/client/19/resources/bundled/user_ulimit/) | Ubuntu, Linux | |
| [yum_package](/client/19/resources/bundled/yum_package/) | CentOS 9 | Supported on Linux. |
| [yum_repository](/client/19/resources/bundled/yum_repository/) | Linux | |
| [yum_repository](/client/19/resources/bundled/yum_repository/) | CentOS 9, RHEL 8 | Supported on Linux. |
| [zypper_package](/client/19/resources/bundled/zypper_package/) | SUSE Linux 15 | |
| [solaris_package](/client/19/resources/bundled/solaris_package/) | Solaris | |
