+++
title = "Supported Chef Infra resources in Agentless Mode"
linkTitle = "Supported resources"

[menu.features]
title = "Supported resources"
identifier = "features/agentless/resources/overview"
parent = "features/agentless/resources"
weight = 10
+++

<!-- markdownlint-disable MD059 -->

The following Chef Infra resources are supported in Agentless Mode.

| **Resources Name** | **Verified Platforms** | **Remarks** |
|---|---|---|
| [alternatives](/resources/bundled/alternatives/) | Ubuntu, Linux | |
| [apt_package](/resources/bundled/apt_package/) | Ubuntu | |
| [apt_preference](/resources/bundled/apt_preference/) | Ubuntu, Linux | |
| [apt_repository](/resources/bundled/apt_repository/) | Ubuntu, Linux | |
| [apt_update](/resources/bundled/apt_update/) | Ubuntu, Linux | |
| [bash](/resources/bundled/bash/) | Ubuntu, Linux, Solaris, Alpine, SUSE | |
| [breakpoint](/resources/bundled/breakpoint/) | Ubuntu, Linux | |
| [chef_acl](/resources/bundled/chef_acl/) | Ubuntu, Linux, CentOS 9 | |
| [chef_client](/resources/bundled/chef_client/) | Ubuntu 24.04, Linux Red Hat 9, Solaris, Alpine, SUSE | |
| [chef_client_config](/resources/bundled/chef_client_config/) | Ubuntu, Linux, Solaris, Alpine, SUSE | |
| [chef_container](/resources/bundled/chef_container/) | Ubuntu, Linux | |
| [chef_data_bag](/resources/bundled/chef_data_bag/) | Ubuntu, Linux | |
| [chef_environment](/resources/bundled/chef_environment/) | Ubuntu, Linux | |
| [chef_group](/resources/bundled/chef_group/) | Ubuntu 24.04 and 18.04, RHEL | |
| [chef_node](/resources/bundled/chef_node/) | Ubuntu 24.04, Linux Red Hat 9 | |
| [chef_organization](/resources/bundled/chef_organization/) | Ubuntu 24.04 and 18.04, RHEL | |
| [chef_role](/resources/bundled/chef_role/) | Ubuntu 24.04, Linux Red Hat 9, Solaris, Alpine, SUSE | |
| [chef_sleep](/resources/bundled/chef_sleep/) | Ubuntu, Linux | |
| [chef_user](/resources/bundled/chef_user/) | Ubuntu 24.04 and 18.04, RHEL, Solaris, Alpine, SUSE | |
| [cookbook_file](/resources/bundled/cookbook_file/) | Ubuntu, Linux, Solaris, Alpine, SUSE | |
| [cron](/resources/bundled/cron/) | Ubuntu, Linux, Solaris SunOS, Alpine | |
| [cron_access](/resources/bundled/cron_access/) | Ubuntu, Linux, Solaris SunOS, Alpine | |
| [cron_d](/resources/bundled/cron_d/) | Ubuntu, Linux | |
| [csh](/resources/bundled/csh/) | Ubuntu 24.04, Linux Red Hat 9, Alpine | |
| [directory](/resources/bundled/directory/) | Ubuntu, Linux, Solaris, Alpine, SUSE | |
| [execute](/resources/bundled/execute/) | Ubuntu, Linux, Solaris, Alpine, SUSE | |
| [file](/resources/bundled/file/) | Ubuntu, Linux, Solaris, Alpine, SUSE | |
| [freebsd_package](/resources/bundled/freebsd_package/) | FreeBSD 14 | Supported on FreeBSD. |
| [git](/resources/bundled/git/) | Ubuntu, Linux, Solaris, Alpine, SUSE | |
| [group](/resources/bundled/group/) | Ubuntu, Linux, Solaris, Alpine, SUSE | |
| [habitat_config](/resources/bundled/habitat_config/) | Ubuntu 24.04, Linux Red Hat 9, Solaris, Alpine, SUSE | |
| [habitat_install](/resources/bundled/habitat_install/) | Ubuntu, Linux, Solaris, Alpine, SUSE | |
| [habitat_package](/resources/bundled/habitat_package/) | Ubuntu, Linux, Solaris, Alpine, SUSE | |
| [habitat_service](/resources/bundled/habitat_service/) | Ubuntu, Linux | |
| [habitat_sup](/resources/bundled/habitat_sup/) | Ubuntu, Linux | |
| [hostname](/resources/bundled/hostname/) | Ubuntu, Linux | |
| [http_request](/resources/bundled/http_request/) | Ubuntu, Linux, , Solaris, Alpine, SUSE | |
| [ifconfig](/resources/bundled/ifconfig/) | Ubuntu, Linux | |
| [inspec_input](/resources/bundled/inspec_input/) | Ubuntu 24.04, Linux Red Hat 9 | |
| [inspec_waiver](/resources/bundled/inspec_waiver/) | Ubuntu, Linux | |
| [inspec_waiver_file_entry](/resources/bundled/inspec_waiver_file_entry/) | Ubuntu, Linux | |
| [kernel_module](/resources/bundled/kernel_module/) | Ubuntu, Linux | |
| [ksh](/resources/bundled/ksh/) | Ubuntu 24.04, Linux Red Hat 9, Solaris, Alpine, SUSE | |
| [link](/resources/bundled/link/) | Ubuntu, Linux, Solaris, Alpine, SUSE | |
| [locale](/resources/bundled/locale/) | Ubuntu | |
| [log](/resources/bundled/log/) | Ubuntu, Linux, Solaris, Alpine, SUSE | |
| [mount](/resources/bundled/mount/) | Ubuntu 24.04, CentOS 9 | |
| [notify_group](/resources/bundled/notify_group/) | Ubuntu, Linux | |
| [ohai](/resources/bundled/ohai/) | Ubuntu, Linux | |
| [ohai_hint](/resources/bundled/ohai_hint/) | Ubuntu, Linux | |
| [package](/resources/bundled/package/) | Ubuntu, Linux, CentOS 9, Solaris, Alpine, SUSE | |
| [perl](/resources/bundled/perl/) | Ubuntu | |
| [python](/resources/bundled/python/) | Ubuntu 24.04, Linux Red Hat 9, Solaris, Alpine, SUSE | |
| [reboot](/resources/bundled/reboot/) | Ubuntu, Linux | |
| [remote_file](/resources/bundled/remote_file/) | Ubuntu, Linux, CentOS 9, Solaris, Alpine, SUSE | |
| [rhsm_errata](/resources/bundled/rhsm_errata/) | Linux (redhat) | |
| [rhsm_errata_level](/resources/bundled/rhsm_errata_level/) | Linux (redhat) | |
| [rhsm_register](/resources/bundled/rhsm_register/) | Linux (redhat) | |
| [rhsm_repo](/resources/bundled/rhsm_repo/) | Linux (redhat) | |
| [rhsm_subscription](/resources/bundled/rhsm_subscription/) | Linux (redhat) | |
| [route](/resources/bundled/route/) | Ubuntu 24.04 / CentOS 9 | |
| [rpm_package](/resources/bundled/rpm_package/) | CentOS 9 | The RPM package must be locally available on the remote system. |
| [ruby_block](/resources/bundled/ruby_block/) | Ubuntu, Linux, CentOS 9 | |
| [script](/resources/bundled/script/) | Ubuntu 24.04, Linux Red Hat 9, , Solaris, Alpine | |
| [selinux_boolean](/resources/bundled/selinux_boolean/) | Ubuntu, Linux | |
| [selinux_fcontext](/resources/bundled/selinux_fcontext/) | Ubuntu, Linux | |
| [selinux_install](/resources/bundled/selinux_install/) | Ubuntu, Linux | |
| [selinux_login](/resources/bundled/selinux_login/) | Ubuntu, Linux | |
| [selinux_module](/resources/bundled/selinux_module/) | Ubuntu, Linux | |
| [selinux_permissive](/resources/bundled/selinux_permissive/) | Ubuntu, Linux | |
| [selinux_port](/resources/bundled/selinux_port/) | Ubuntu, Linux | |
| [selinux_state](/resources/bundled/selinux_state/) | Ubuntu, Linux | |
| [selinux_user](/resources/bundled/selinux_user/) | Ubuntu, Linux | |
| [service](/resources/bundled/service/) | Ubuntu, Linux, CentOS 9, Solaris, Alpine, SUSE | `crond` for Linux |
| [snap_package](/resources/bundled/snap_package/) | Ubuntu 24.04 | Supported on Linux. |
| [ssh_known_hosts_entry](/resources/bundled/ssh_known_hosts_entry/) | Ubuntu, Linux | |
| [subversion](/resources/bundled/subversion/) | Ubuntu 24.04, Linux Red Hat 9, CentOS 9 | The subversion resource has known bugs and may not work as expected. For more information, see the Chef GitHub issues [#4050](https://github.com/chef/chef/issues/4050) and [#4257](https://github.com/chef/chef/issues/4257). |
| [sudo](/resources/bundled/sudo/) | Ubuntu, Linux, CentOS 9, Solaris, Alpine, SUSE | |
| [swap_file](/resources/bundled/swap_file/) | Ubuntu, Linux | |
| [sysctl](/resources/bundled/sysctl/) | Ubuntu, Linux | |
| [systemd_unit](/resources/bundled/systemd_unit/) | Ubuntu, Linux | |
| [template](/resources/bundled/template/) | Ubuntu, Linux, CentOS 9, Solaris, Alpine, SUSE | Require absolute path for source attribute. |
| [timezone](/resources/bundled/timezone/) | Linux, Solaris, Alpine, SUSE | |
| [user](/resources/bundled/user/) | Ubuntu, Linux | |
| [user_ulimit](/resources/bundled/user_ulimit/) | Ubuntu, Linux | |
| [yum_package](/resources/bundled/yum_package/) | CentOS 9 | Supported on Linux. |
| [yum_repository](/resources/bundled/yum_repository/) | Linux | |
| [yum_repository](/resources/bundled/yum_repository/) | CentOS 9, RHEL 8 | Supported on Linux. |
| [zypper_package](/resources/bundled/zypper_package/) | SUSE Linux 15 | |
| [solaris_package](/resources/bundled/solaris_package/) | Solaris | |
