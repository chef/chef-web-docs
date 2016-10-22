.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings:

``chef_solr['commit_interval']``
   The frequency (in seconds) at which node objects are added to the Apache Solr search index. When data is committed to the Apache Solr index, all incoming updates are blocked. If the duration between updates is too short, it is possible for the rate at which updates are asked to occur to be faster than the rate at which objects can be actually committed. Default value: ``60000`` (every 60 seconds).

``chef_solr['data_dir']``
   The directory in which on-disk data is stored. The default value is the recommended value. Default value: ``/var/opt/chef-server/chef-solr/data``.

``chef_solr['dir']``
   The working directory. The default value is the recommended value. Default value: ``/var/opt/chef-server/chef-solr``.

``chef_solr['enable']``
   Default value: ``true``.

``chef_solr['ha']``
   Run the Chef server in a high availability topology. Default value: ``false``.

``chef_solr['heap_size']``
   Default value: ``nil``.

``chef_solr['ip_address']``
   Default value: ``0.0.0.0``.

``chef_solr['java_opts']``
   Default value: ``(empty)``.

``chef_solr['log_directory']``
   The directory in which log files are located. Default value: ``/var/log/chef-server/chef-solr``.

``chef_solr['max_commit_docs']``
   The frequency (in documents) at which node objects are added to the Apache Solr search index. When data is committed to the Apache Solr index, all incoming updates are blocked. If the duration between updates is too short, it is possible for the rate at which updates are asked to occur to be faster than the rate at which objects can be actually committed. Default value: ``1000`` (every 1000 documents).

``chef_solr['max_field_length']``
   The maximum field length (in number of tokens/terms). If a field length exceeds this value, Apache Solr may not be able to complete building the index. Default value: ``100000`` (increased from the Apache Solr default value of ``10000``).

``chef_solr['max_merge_docs']``
   The maximum number of index segments allowed before they are merged into a single index. Default value: ``2147483647``.

``chef_solr['merge_factor']``
   The maximum number of document updates that can be stored in memory before being flushed and added to the current index segment. Default value: ``100``.

``chef_solr['new_size']``
   Default value: ``nil``.

``chef_solr['poll_seconds']``
   Default value: ``20``.

``chef_solr['port']``
   The port on which the service is to listen. Default value: ``8983``.

``chef_solr['ram_buffer_size']``
   Default value: ``200``.

``chef_solr['vip']``
   The virtual IP address. Default value: ``127.0.0.1``.
