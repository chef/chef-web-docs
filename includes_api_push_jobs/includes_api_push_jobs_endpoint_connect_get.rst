.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to get information that is needed to connect to the |chef server|.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /organizations/ORG_NAME/pushy/connect/NODE_NAME

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "host": "opc1.opscode.com", 
     "push_jobs": {
       "heartbeat": {
         "out_addr": "tcp://10.10.1.5:10000", 
         "interval": 15, 
         "offline_threshold": 3, 
         "online_threshold": 2
       }, 
       "command_addr": "tcp://10.10.1.5:10001",
     }, 
     "public_key": "-----BEGIN PUBLIC KEY-----
                    MIIBIjANBgkqhkiG923BAQEFAAOCAQ8AMIIBCgKCAQEAvndddfLhltEPZzgrdZjk
                    2xdGKDRaF/DxRE/Tdj2T2q0+MwXeK1XHeZJZdrhvfc7Lpf4KdlYdMjk6mjF5KGmJ
                    a3omes8emyu7yfGs4tvn+5BKhaHPHCRA0vskE9/uIt9J/RgZIE0A3dBtf+9chY7J
                    qJujIE9f3uJCknBf5jD4234fggrhb6mI9q2RO0xq10Omk/zpYIM4a20AMYxSmryM
                    R3ivdiviW2hDZMdEHx0Au3+e4wkh1uiXCgdfhvr34gtyiPz5uwNAkzB8Z9qKl0G6
                    Ju7lEl3oJFqu0XtdghsgbhyfgnymnbhMnsQiTKEaUNmasfO/dIHSJmJpGccZFjwp
                    -----END PUBLIC KEY-----", 
     "lifetime":3600
   }

where:

* ``command_addr`` is 
* ``heartbeat`` is 
* ``host`` is the host name for the sender
* ``interval`` is the interval (in seconds) between heartbeat messages
* ``lifetime`` is the amount of time (in seconds) for which a configuration is good. A node should reload configuration information after this amount of time is expired
* ``offline_threshold`` is the number of intervals that must be missed before a node is marked as offline
* ``online_threshold`` is the number of intervals that must be missed before a node is marked as online
* ``out_addr`` is the URL for the heartbeat broadcast service
* ``public_key`` is the signing key used by the |push jobs| server
* ``push_jobs`` is 

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - |response code 200 ok|
   * - ``400``
     - |response code 400 bad request|
   * - ``401``
     - |response code 401 unauthorized|
   * - ``403``
     - |response code 403 forbidden|
   * - ``404``
     - |response code 404 not found|