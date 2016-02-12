.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Every request made by the |chef client| to the |chef server| must be an authenticated request using the |api chef server| and a private key. When the |chef client| makes a request to the |chef server|, the |chef client| authenticates each request using a private key located in ``/etc/chef/client.pem``. 

However, during the first |chef client| run, this private key does not exist. Instead, the |chef client| will attempt to use the private key assigned to the |chef validator|, located in ``/etc/chef/validation.pem``. (If, for any reason, the |chef validator| is unable to make an authenticated request to the |chef server|, the initial |chef client| run will fail.)

During the initial |chef client| run, the |chef client| will register with the |chef server| using the private key assigned to the |chef validator|, after which the |chef client| will obtain a ``client.pem`` private key for all future authentication requests to the |chef server|. 

After the initial |chef client| run has completed successfully, the |chef validator| is no longer required and may be deleted from the node. Use the ``delete_validation`` recipe found in the ``chef-client`` cookbook (https://github.com/chef-cookbooks/chef-client) to remove the |chef validator|.
