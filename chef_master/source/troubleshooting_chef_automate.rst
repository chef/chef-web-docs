=====================================================
Troubleshooting Chef Automate
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/troubleshooting_chef_automate.rst>`__

.. tag chef_automate_mark

.. image:: ../../images/chef_automate_full.png
   :width: 40px
   :height: 17px

.. end_tag

The following are issues that you may encounter during the setup and usage of Chef Automate.

Preflight Check
=====================================================

Error Codes
-----------------------------------------------------
This is a list of possible error codes and remediation steps you might see when running the ``preflight-check`` command before setting up your Chef Automate server:

*   PF01: The system does not have this given directory or is not writable.

    *   Please create the directory or make sure it is writable.

*   PF02: The system umask is not 0022.

    *   Please change it to 0022.

*   PF03: System has less than 4 CPU cores.

    *   Please increase CPU cores to at least 4.

*   PF04: System has less than 80GB disk space at ``/var``.

    *   Please increase free disk space at ``/var`` to at least 80GB.

*   PF05: System has less than 16GB of free memory.

    *   Please increase free memory to at least 16GB.

*   PF06: Another process is using this port on the system.

    *   Please free this port on the system.

*   PF07: System does not have this software installed.

    *   Please install this software via the given command.

*   PF08: The system ``sysctl`` setting is not a recommended setting.

    *   Set the ``sysctl`` parameter to the recommended value.

*   PF09: The transparent hugepage setting is not a recommended setting.

    *   Set the transparent hugepage setting to the recommended value.

*   PF10: The minimum ephemeral ports count is not high enough.

    *   Set the ephemeral port range to a larger value.

*   PF11: The devices for the mounted directory are not mounted with the suggested option.

    *   Update ``/etc/fstab`` or systemd mount unit for the device to have the recommended settings.

*   PF12: The block device read-ahead setting is not within the within the suggested range.

    *   Set the read-ahead for the device to the recommended range.

*   PF13: The I/O scheduler for the device is not suggested scheduler.

    *   Set the I/O scheduler for the device to the recommended setting.

Note that the ``preflight-check`` will provide more detailed remediation steps than those listed here, based on the specific problems that it encounters. For example:

.. code-block:: none

   * Error PF08: The vm.swappiness level should satisfy: '>= 1, <= 20'
     Remedy: Set the vm.swappiness: 'sudo sysctl -w vm.swappiness=1'

Recommended System Configuration
-----------------------------------------------------
Chef Automate's preflight checks give recommendations that are generally advisable for most hardware options. The following is a list of suggestions that we have found will positively impact performance.

*   ``vm.swappiness`` should between ``1`` and ``20``
    Most Chef Automate installations run several shared services on a single machine. We recommend having swap enabled as a failsafe. Without it we've seen services like Postgresql and Elasticsearch trigger the OOM-killer for other system and Automate services. Swappiness should be low to discourage the use of swap, because the increased disk I/O can adversely impact Elasticsearch and Postgresql.

*   ``fs.file-max`` should be at least ``64,000``
    Elasticsearch, Postgresql, and nginx make extensive use of temporary files and require several thousand open file handles for normal operations.

*   ``vm.max_map_count`` should be at least ``256,000``
    Elasticsearch uses a mix of NioFS and MMapFS for open files, and requires many maps for normal operation.

*   ``vm.dirty_ratio`` should be between ``5`` and ``30``
    ``vm.dirty_backgroud_ratio`` should be between ``10`` and ``60``
    ``vm.dirty_expire_centisecs`` should be between ``10,000`` and ``30,000``
    These page cache controls handle how often dirty pages are purged to disk. These will differ depending on hardware, but in general these recommendations are a good baseline for performance vs. safety.

*   ``net.ipv4.ip_local_port_range`` should be at least ``65,000``
    Chef Automate has several services that utilize HTTP connections, each of which require ephemeral ports. Setting this too low can cause services to either fail or wait for open ports.

*   ``/etc/fstab`` should mount the Chef Automate data directory with ``noatime`` if the disk is formatted with ``ext3`` or ``ext4``.
    Failing to mount the disk that contains the Chef Automate data directory with `noatime` will cause every disk read operation an access time write operation. That adds quite a bit of disk I/O for very little use.

*   ``blockdev --getra`` for the disk that contains the Chef Automate data directory should be at least ``4096``. This setting will vary greatly depending on hardware and can sometimes be set much higher. Elasticsearch utilizes large files for indices and increasing the read-ahead can improve performance when reading those long sequential files. You will normally see diminishing returns after ``64000``.

*   ``/sys/block/<device>/queue/scheduler`` should be ``noop`` for SSDs or ``deadline`` for rotational disks.
    Depending on the disk type that is being used for the Chef Automate data directory, set the appropriate disk scheduler for maximum performance.

*   ``/sys/kernel/mm/transparent_hugepage/enabled`` should be ``never`` \
    ``/sys/kernel/mm/transparent_hugepage/defrag`` should be ``never`` \

    The version of Postgresql that Chef Automate utilizes is not compatible with transparent hugepages.

Build nodes/Runners
=====================================================

The following are possible issues you might run into when using build nodes and/or runners.

Issue: Waiting for builder.
-----------------------------------------------------
If "waiting for builder" occurs in the log output on a new Chef Automate setup with no existing build nodes, then the Chef Automate server and Chef server are not communicating. To establish communication, try restarting Chef Automate's main service with ``automate-ctl restart delivery``.
If "waiting for builder" occurs in the log output on a Chef Automate setup with existing build nodes, then it indicates incorrect mapping between between v1/v2 build job type and the available builder/runner resources in a Chef Automate cache. Check your project's ``.delivery/config.json`` to confirm that it correctly represents the use of builders/runners, adjust this if necessary, and restart Automate's main service with ``automate-ctl restart delivery``.

If your Chef Automate system has builders(push jobs), then your projects should have the following configuration in .delivery/config.json :

   .. code-block:: json

       {
         "job_dispatch": {
           "version": "v1"
           }
       }

If your Chef Automate system has runners, then your projects should have the following configuration in .delivery/config.json

   .. code-block:: json

       {
         "job_dispatch": {
           "version": "v2"
           }
       }

If the ``.delivery/config.json`` is correct, but jobs are not kicking off, then the best thing to do is restart Automate's main service with ``automate-ctl restart delivery``. After restarting the service, queued change jobs should start being processed by the available resources for that job type.

Issue: No build nodes/runners available.
-----------------------------------------------------

If you see "no build nodes available" in your log output, then you need to set up build nodes.
If you have set up build nodes and are still seeing this error, then you need to check if the build nodes registered with the chef server correctly.  In this case, a correct registration is something that matches your build node query.

By default, Chef Automate build nodes/runners generated by ``automate-ctl install-build-node`` or ``automate-ctl install-runner``, which are respectively tagged as ``delivery-build-node`` and ``delivery-job-runner``. If your delivery.rb contains a custom search query (``delivery['default_search']`` is set), try appending ``" OR tags:delivery-build-node"`` or ``" OR tags:delivery-job-runner"`` to your query.

At a minimum, the build-node and runner configuration includes the following:

If your Chef Automate system has builders(push jobs), then your projects should have the following configuration in .delivery/config.json :

   .. code-block:: json

       {
         "job_dispatch": {
           "version": "v1"
           }
       }

If your Chef Automate system has runners, then your projects should have the following configuration in .delivery/config.json

   .. code-block:: json

       {
         "job_dispatch": {
           "version": "v2"
           }
       }

If you are trying debugging a specific build node or runner and need to ensure that one is available for your projects,
then modify the build-nodes or job_dispatch default search for your project as described in :doc:`Configure a Project </config_json_delivery>`.

SAML Authentication
=======================================================

When setting up SAML authentication, you might run into the following issues where you cannot sign in with SAML.

Issue: The browser shows a blank page.
-----------------------------------------------------

If both of these conditions are true:

* The URL of the blank page is ``https://<yourChef AutomateDomain>/api/v0/e/<enterprise>/saml/auth/<my-saml-name>``
* The logs show ``[error] Ranch listener http terminated in auth_hand_saml_auth:handle/2 with reason: no match of right hand value false in base64:decode_binary/2 line 212``

then the SAML IdP certificate stored in the database needs to be base64-encoded.

You can verify that a certificate is correctly copied by doing the following:

#. Save the certificate to a file (e.g. `CERT`).
#. In the command line, run ``base64 -D CERT | openssl x509 -inform DER -text -noout``.

   The output should be the certificate information, for example

   .. code-block:: text

      Certificate:
         Data:
            Version: 3 (0x2)
            Serial Number:
                  01:4b:41:db:a2:9c
            Signature Algorithm: sha1WithRSAEncryption
            Issuer: C=US, ST=California, L=San Francisco, O=Okta, OU=SSOProvider, CN=getchef/emailAddress=info@okta.com
      ...

      .. note:: The `base64` CLI tool is not as strict in decoding Base64 as Erlang is.

If the output from the above commands displays the certificate info, but you still get the error pattern, then try running your certificate through Erlang:

#. Open an Erlang shell: ``erl``.
#. Type ``{ok, Content} = file:read_file(Path).`` to read the file (note the period at the end).
#. Type ``base64:decode(Content).`` to try decoding the base64-encoded certificate.

If the certificate can be decoded, you should see something like:

.. code-block:: erlang

   > base64:decode(Content).
   <<48,130,3,158,48,130,2,134,160,3,2,1,2,2,6,1,75,65,219,
     162,156,48,13,6,9,42,134,72,134,...>>

and if it can't be decoded:

.. code-block:: erlang

   > base64:decode(Content).
   ** exception error: no match of right hand side value false
       in function  base64:decode_binary/2 (base64.erl, line 212)

Issue: The browser shows the login UI with "SAML login failed!"
-----------------------------------------------------------------

Case #1
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

If you see this error and the logs show ``Invalid assertion {assertion,{error,cert_not_accepted}}``, then the stored certificate is base64-encoded, but is the incorrect certificate for the IdP for signing the assertion response.

To find the correct certificate, you can examine the assertions given by the IdP on successful login:

#. Open Chrome's "Developer Tools" (Alt+Cmd+i on macOS) > Network (4th tab).
#. Select `Preserve Log` (2nd row) and `All` (3rd row).
#. Try logging in via SAML again.
#. Find the request to `consume` (Name column).
#. In the`Header` tab, scroll down to `Form Data` and copy the `SAMLResponse` data.
#. Go to https://www.samltool.com/decode.php and paste the SAMLResponse, click `decode and inflate XML`.
#. Compare the certificate in the XML document (``ds:X509Certificate`` or a similar tag) to the certificate stored in the SAML Setup page.

Case #2
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

If you see this error and the logs show ``[error] Invalid assertion bad_recipient``, then the "Assertion Consumption Service" (ACS)
endpoint configured with the IdP is incorrect.

A configuration mismatch of this kind most likely breaks the interaction completely. Seeing this error hints at a minor mismatch -- most likely concerning the `api_proto` setting.

Follow the steps provided in Case #1 to examine the assertions returned from the IdP and verify that the recipient of the assertion response matches Chef Automate's saml/consume endpoint:

.. code-block:: xml

   <?xml version="1.0" encoding="UTF-8"?>
     <saml2p:Response
        xmlns:saml2p="urn:oasis:names:tc:SAML:2.0:protocol"
        Destination="http://<yourChef AutomateDomain>/api/v0/e/cd/saml/consume"
        ID="id106938446989890821534691506"
        InResponseTo="_209b55372ca56aee1457a2f6a5eced8e"
        IssueInstant="2016-06-13T12:03:04.758Z"
        Version="2.0"
        xmlns:xs="http://www.w3.org/2001/XMLSchema">

Case #3
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

If you see this error and the logs show ``[error] Invalid assertion bad_in_response_to``, then the response does not match a request.

.. code-block:: xml

   <?xml version="1.0" encoding="UTF-8"?>
     <saml2p:Response
        xmlns:saml2p="urn:oasis:names:tc:SAML:2.0:protocol"
        Destination="http://<delivery>/api/v0/e/cd/saml/consume"
        ID="id106938446989890821534691506"
        InResponseTo="_209b55372ca56aee1457a2f6a5eced8e"
        IssueInstant="2016-06-13T12:03:04.758Z"
        Version="2.0"
        xmlns:xs="http://www.w3.org/2001/XMLSchema">

This can happen when either the IdP is not compliant to the SAML specs, or when the assertion is too late, that is, when the initiation of the SAML login process
(the redirect to your IdP) has been longer than 15 minutes.

Issue: The browser shows the login UI with "Invalid user, login failed!"
-------------------------------------------------------------------------

Chef Automate does not have a user-record for the user information from the SAML assertion.
This can be triggered by either:

* Initiating SAML authentication when trying to log in by entering a username of a Chef Automate user with authentication type SAML.
* When redirected to the SAML IdP, authenticating as a different user (not known to Chef Automate).

This can also indicate a change in NameId settings.

Visibility
====================================================================

The following is an issue you might run into when using the visibility capabilities in Chef Automate.

Issue: Data does not show up in Chef Automate UI.
------------------------------------------------------------------------------------

.. tag chef_automate_visibility_no_data_troubleshoot

If an organization does not have any nodes associated with it, it does not show up in the **Nodes** section of the Chef Automate UI.
This is also true for roles, cookbooks, recipes, attributes, resources, node names, and environments. Only those items that have a node associated with them will appear in the UI. Chef Automate has all the data for all of these, but does not highlight them in the UI. This is designed to keep the UI focused on the nodes in your cluster.

.. end_tag

Issue: Changing default token causes data collector request failures
------------------------------------------------------------------------------------

There is a bug in Chef Server 12.15.8 where setting the data collector token in ``/etc/opscode/chef-server.rb`` away from the default works, but only once. Afterwards, you will no longer be able to reset the token. It will be stuck because the Veil secure credential storage now takes precedence over secrets set in ``/etc/delivery/delivery.rb``. Currently, the token is considered to be a secret.

If you continually receive ``401`` errors in ``/var/log/delivery/nginx/delivery.access.log`` for data collector requests, but your configuration looks good, this issue is the cause.

You can find what token is being sent by watching output from the following ``tcpdump`` command on the Automate system. Look closely at the output for the string ``x-data-collector-token``, and you will see that the token ``strangeCall`` follows. Use Ctrl-C to exit the ``tcpdump``.

.. code-block:: shell

   tcpdump -i lo -XX -s0 -vv 'port 9611' | tee -a get-that-token.txt

   11:05:58.630201 IP (tos 0x0, ttl 64, id 5169, offset 0, flags [DF], proto TCP (6), length 1658)
    localhost.39068 > localhost.9611: Flags [P.], cksum 0x046f (incorrect -> 0xfb07), seq 1:1607, ack 1, win 342, options   [nop,nop,TS val 34662932 ecr 34662932], length 1606
        0x0000:  0000 0000 0000 0000 0000 0000 0800 4500  ..............E.
        0x0010:  067a 1431 4000 4006 224b 7f00 0001 7f00  .z.1@.@."K......
        0x0020:  0001 989c 258b fc06 fe3c 842e 5bc4 8018  ....%....<..[...
        0x0030:  0156 046f 0000 0101 080a 0210 ea14 0210  .V.o............
        0x0040:  ea14 504f 5354 202f 6461 7461 2d63 6f6c  ..POST./data-col
        0x0050:  6c65 6374 6f72 2f76 302f 2048 5454 502f  lector/v0/.HTTP/
        0x0060:  312e 310d 0a48 6f73 743a 2064 6174 612d  1.1..Host:.data-
        0x0070:  636f 6c6c 6563 746f 723a 3434 330d 0a58  collector:443..X
        0x0080:  2d52 6561 6c2d 4950 3a20 3130 2e30 2e33  -Real-IP:.10.0.3
        0x0090:  2e32 3330 0d0a 582d 5363 6865 6d65 3a20  .230..X-Scheme:.
        0x00a0:  6874 7470 730d 0a58 2d46 6f72 7761 7264  https..X-Forward
        0x00b0:  6564 2d46 6f72 3a20 3130 2e30 2e33 2e32  ed-For:.10.0.3.2
        0x00c0:  3330 0d0a 582d 466f 7277 6172 6465 642d  30..X-Forwarded-
        0x00d0:  5072 6f74 6f3a 2068 7474 7073 0d0a 436f  Proto:.https..Co
        0x00e0:  6e6e 6563 7469 6f6e 3a20 636c 6f73 650d  nnection:.close.
        0x00f0:  0a43 6f6e 7465 6e74 2d4c 656e 6774 683a  .Content-Length:
        0x0100:  2033 3533 0d0a 782d 6461 7461 2d63 6f6c  .353..x-data-col
        0x0110:  6c65 6374 6f72 2d74 6f6b 656e 3a20 7374  lector-token:.st
        0x0120:  7261 6e67 6543 616c 6c0d 0a78 2d64 6174  rangeCall

You can work around this bug by issuing the following commands on the Chef Server, replacing ``SECRET`` with the token that the Automate system has been configured to use:

.. code-block:: shell

   chef-server-ctl set-secret data_collector token 'SECRET'
   chef-server-ctl restart nginx

It's also recommended that you configure that same token in ``/etc/opscode/chef-server.rb``, and then run ``chef-server-ctl reconfigure``. This will allow you to confirm that the correct token is used to access the Automate system.
