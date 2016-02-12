.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A completed |chef server rb| configuration file for a four server tiered |chef server| cluster, consisting of:

.. list-table::
   :widths: 100 150 150 100
   :header-rows: 1

   * - FQDN
     - Real IP Address
     - Cluster IP Address
     - Role
   * - be1.example.com
     - 192.168.4.1
     - 10.1.2.10
     - backend
   * - be2.example.com
     - 192.168.4.6
     - 10.1.2.12
     - backend
   * - fe1.example.com
     - 192.168.4.2
     - 
     - frontend
   * - fe2.example.com
     - 192.168.4.3
     - 
     - frontend
   * - fe3.example.com
     - 192.168.4.4
     - 
     - frontend
   * - chef.example.com
     - 192.168.4.5
     - 
     - load balanced frontend VIP
   * - be.example.com
     - 192.168.4.7
     - 
     - load balanced backend VIP

Looks like this:

.. code-block:: ruby

   topology "ha"
   
   server "be1.example.com",
     :ipaddress => "192.168.4.1",
     :role => "backend",
     :bootstrap => true,
     :cluster_ipaddress => "10.1.2.10"
   
   server "be2.example.com",
     :ipaddress => "192.168.4.6",
     :role => "backend",
     :cluster_ipaddress => "10.1.2.12"
   
   backend_vip "be.example.com",
     :ipaddress => "192.168.4.7",
     :device => "eth0"
   
   server "fe1.example.com",
     :ipaddress => "192.168.4.2",
     :role => "frontend"
   
   server "fe2.example.com",
     :ipaddress => "192.168.4.3",
     :role => "frontend"
   
   server "fe3.example.com",
     :ipaddress => "192.168.4.4",
     :role => "frontend"
   
   api_fqdn "chef.example.com"

