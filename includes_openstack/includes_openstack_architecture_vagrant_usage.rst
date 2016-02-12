.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 

From the |openstack chef_repo|, launch the ``ubuntu1204`` virtual machine with |vagrant|. This will take several minutes as it does the ``chef-client`` run for the ``allinone-compute``.

.. code-block:: bash

    $ vagrant up ubuntu1204

SSH into the ``ubuntu1204`` virtual machine with |vagrant|.

.. code-block:: bash

    $ vagrant ssh ubuntu1204
    Welcome to Ubuntu 12.04.2 LTS (GNU/Linux 3.5.0-23-generic x86_64)

     * Documentation:  https://help.ubuntu.com/

    96 packages can be updated.
    48 updates are security updates.

    Last login: Sat May 11 05:55:03 2013 from 10.0.2.2
    vagrant@ubuntu1204:~$

All commands after this are actually run from within the VM. ``sudo`` to the ``root`` user and source the ``openrc`` file to configure the shell environment for |openstack|.

.. code-block:: bash

    vagrant@ubuntu1204:~$ sudo su -
    root@ubuntu1204:~# source /root/openrc

There are several basic checks that may be run to establish that the |openstack| deployment is operating properly. List the |openstack nova| compute services that are running:

.. code-block:: bash

    root@ubuntu1204:~# nova service-list
    +------------------+------------+----------+---------+-------+----------------------------+
    | Binary           | Host       | Zone     | Status  | State | Updated_at                 |
    +------------------+------------+----------+---------+-------+----------------------------+
    | nova-cert        | ubuntu1204 | internal | enabled | up    | 2013-11-25T04:35:04.000000 |
    | nova-compute     | ubuntu1204 | nova     | enabled | up    | 2013-11-25T04:35:07.000000 |
    | nova-conductor   | ubuntu1204 | internal | enabled | up    | 2013-11-25T04:35:00.000000 |
    | nova-consoleauth | ubuntu1204 | internal | enabled | up    | 2013-11-25T04:35:05.000000 |
    | nova-network     | ubuntu1204 | internal | enabled | up    | 2013-11-25T04:35:07.000000 |
    | nova-scheduler   | ubuntu1204 | internal | enabled | up    | 2013-11-25T04:35:00.000000 |
    +------------------+------------+----------+---------+-------+----------------------------+

.. List the Quantum Network services that are running:
.. # quantum agent-list
.. List the Nova Compute hypervisors that are running:
.. # nova hypervisor-list

Note that ``nova-network`` is listed, this will be updated soon and replaced by Quantum Network services. Next list the Identity catalog.

.. code-block:: bash

    root@ubuntu1204:~# keystone catalog
    Service: compute
    +-------------+-----------------------------------------------------------+
    |   Property  |                           Value                           |
    +-------------+-----------------------------------------------------------+
    |   adminURL  | http://127.0.0.1:8774/v2/c32e2a09541648f7b6ab67475a88103b |
    | internalURL | http://127.0.0.1:8774/v2/c32e2a09541648f7b6ab67475a88103b |
    |  publicURL  | http://127.0.0.1:8774/v2/c32e2a09541648f7b6ab67475a88103b |
    |    region   |                         RegionOne                         |
    +-------------+-----------------------------------------------------------+
    Service: network
    +-------------+-----------------------+
    |   Property  |         Value         |
    +-------------+-----------------------+
    |   adminURL  | http://127.0.0.1:9696 |
    | internalURL | http://127.0.0.1:9696 |
    |  publicURL  | http://127.0.0.1:9696 |
    |    region   |       RegionOne       |
    +-------------+-----------------------+
    Service: image
    +-------------+--------------------------+
    |   Property  |          Value           |
    +-------------+--------------------------+
    |   adminURL  | http://127.0.0.1:9292/v2 |
    | internalURL | http://127.0.0.1:9292/v2 |
    |  publicURL  | http://127.0.0.1:9292/v2 |
    |    region   |        RegionOne         |
    +-------------+--------------------------+
    Service: volume
    +-------------+-----------------------------------------------------------+
    |   Property  |                           Value                           |
    +-------------+-----------------------------------------------------------+
    |   adminURL  | http://127.0.0.1:8776/v1/c32e2a09541648f7b6ab67475a88103b |
    | internalURL | http://127.0.0.1:8776/v1/c32e2a09541648f7b6ab67475a88103b |
    |  publicURL  | http://127.0.0.1:8776/v1/c32e2a09541648f7b6ab67475a88103b |
    |    region   |                         RegionOne                         |
    +-------------+-----------------------------------------------------------+
    Service: ec2
    +-------------+--------------------------------------+
    |   Property  |                Value                 |
    +-------------+--------------------------------------+
    |   adminURL  | http://127.0.0.1:8773/services/Cloud |
    | internalURL | http://127.0.0.1:8773/services/Cloud |
    |  publicURL  | http://127.0.0.1:8773/services/Cloud |
    |    region   |              RegionOne               |
    +-------------+--------------------------------------+
    Service: identity
    +-------------+-----------------------------+
    |   Property  |            Value            |
    +-------------+-----------------------------+
    |   adminURL  | http://127.0.0.1:35357/v2.0 |
    | internalURL |  http://127.0.0.1:5000/v2.0 |
    |  publicURL  |  http://127.0.0.1:5000/v2.0 |
    |    region   |          RegionOne          |
    +-------------+-----------------------------+

List the images and favors of machines available for creating instances:

.. code-block:: bash

    root@ubuntu1204:~# nova image-list
    +--------------------------------------+--------+--------+--------+
    | ID                                   | Name   | Status | Server |
    +--------------------------------------+--------+--------+--------+
    | 8dd388c2-0927-4c93-bafb-a9e132fe4526 | cirros | ACTIVE |        |
    +--------------------------------------+--------+--------+--------+
    root@ubuntu1204:~# nova flavor-list
    +----+-----------+-----------+------+-----------+------+-------+-------------+-----------+-------------+
    | ID | Name      | Memory_MB | Disk | Ephemeral | Swap | VCPUs | RXTX_Factor | Is_Public | extra_specs |
    +----+-----------+-----------+------+-----------+------+-------+-------------+-----------+-------------+
    | 1  | m1.tiny   | 512       | 0    | 0         |      | 1     | 1.0         | True      | {}          |
    | 2  | m1.small  | 2048      | 20   | 0         |      | 1     | 1.0         | True      | {}          |
    | 3  | m1.medium | 4096      | 40   | 0         |      | 2     | 1.0         | True      | {}          |
    | 4  | m1.large  | 8192      | 80   | 0         |      | 4     | 1.0         | True      | {}          |
    | 5  | m1.xlarge | 16384     | 160  | 0         |      | 8     | 1.0         | True      | {}          |
    +----+-----------+-----------+------+-----------+------+-------+-------------+-----------+-------------+

The ``cirros`` |linux| base image is installed during the installation because the ``node['openstack']['image']['image_upload']`` attribute is set to ``true`` in the ``vagrant`` environment. Now create an instance named ``test1`` with the size of ``m1.tiny`` and image type of ``cirros`` (this may take a few minutes).

.. code-block:: bash

    root@ubuntu1204:~# nova boot test1 --image cirros --flavor 1 --poll
    +-------------------------------------+--------------------------------------+
    | Property                            | Value                                |
    +-------------------------------------+--------------------------------------+
    | OS-EXT-STS:task_state               | scheduling                           |
    | image                               | cirros                               |
    | OS-EXT-STS:vm_state                 | building                             |
    | OS-EXT-SRV-ATTR:instance_name       | instance-00000001                    |
    | flavor                              | m1.tiny                              |
    | id                                  | fd52d006-086f-4064-84e2-316684b03578 |
    | security_groups                     | [{u'name': u'default'}]              |
    | user_id                             | e2b2974738174924bc955c7441721894     |
    | OS-DCF:diskConfig                   | MANUAL                               |
    | accessIPv4                          |                                      |
    | accessIPv6                          |                                      |
    | progress                            | 0                                    |
    | OS-EXT-STS:power_state              | 0                                    |
    | OS-EXT-AZ:availability_zone         | nova                                 |
    | config_drive                        |                                      |
    | status                              | BUILD                                |
    | updated                             | 2013-11-25T04:39:27Z                 |
    | hostId                              |                                      |
    | OS-EXT-SRV-ATTR:host                | None                                 |
    | key_name                            | None                                 |
    | OS-EXT-SRV-ATTR:hypervisor_hostname | None                                 |
    | name                                | test1                                |
    | adminPass                           | Uqa6u73rxngJ                         |
    | tenant_id                           | c32e2a09541648f7b6ab67475a88103b     |
    | created                             | 2013-11-25T04:39:27Z                 |
    | metadata                            | {}                                   |
    +-------------------------------------+--------------------------------------+

    Instance building... 100% complete
    Finished

The instance is now listed as ``ACTIVE``.

.. code-block:: bash

    root@ubuntu1204:~# nova list
    +--------------------------------------+-------+--------+----------------------+
    | ID                                   | Name  | Status | Networks             |
    +--------------------------------------+-------+--------+----------------------+
    | fd52d006-086f-4064-84e2-316684b03578 | test1 | ACTIVE | public=192.168.100.2 |
    +--------------------------------------+-------+--------+----------------------+

SSH into the instance with the user 'cirros' and the password 'cubswin:)':

.. code-block:: bash

    root@ubuntu1204:~# ssh cirros@192.168.100.2
    The authenticity of host '192.168.100.2 (192.168.100.2)' can't be established.
    RSA key fingerprint is 72:6d:33:55:d9:2b:2b:dc:e8:c3:5a:e9:43:f5:0d:1a.
    Are you sure you want to continue connecting (yes/no)? yes
    Warning: Permanently added '192.168.100.2' (RSA) to the list of known hosts.
    cirros@192.168.100.2's password:
    $ uname -a
    Linux cirros 3.0.0-12-virtual #20-Ubuntu SMP Fri Oct 7 18:19:02 UTC 2011 x86_64 GNU/Linux
    $ exit
    Connection to 192.168.100.2 closed.

.. Depending on the IP address of your Vagrant instance, you may connect to the OpenStack Dashboard at http://...:8443

When you are finished with your testing, exit and destroy the |vagrant| virtual machine:

.. code-block:: bash

    root@ubuntu1204:~# exit
    logout
    vagrant@ubuntu1204:~$ exit
    logout
    Connection to 127.0.0.1 closed.
    $ vagrant destroy ubuntu1204 -f
    [ubuntu1204] Forcing shutdown of VM...
    [ubuntu1204] Destroying VM and associated drives...
    [Chef Zero] Stopping Chef Zero
    [ubuntu1204] Running cleanup tasks for 'chef_client' provisioner...
