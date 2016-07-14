.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``PUT`` method is used to update the details for an existing alias.

This method has no parameters.

**Request**

.. code-block:: xml

   PUT /organizations/NAME/aliases/ID

with a request body similar to:

.. code-block:: javascript

   {
     "type": "object",
     "properties": {
       "name": {
         "description": "The name of the alias",
         "type": "string"
       },
       "modified_by": {
         "description": "user last modified",
         "type": "string",
         "format": "username"
       },
       "notification_type": {
         "description": "type of alias (e.g. hipchat, http)",
         "type": "string",
         "enum": [
           "http",
           "hipchat"
         ]
       },
       "delivery_options": {
         "description": "set of settings this notification_type needs",
         "type": "object",
         "oneOf": [
           {"$ref": "#/definitions/hipchat"},
           {"$ref": "#/definitions/http"}
         ]
       }
     },
     "required": [ "notification_type", "modified_by", "name" ],
     "definitions": {
       "hipchat": {
         "description": "Notifier - Hipchat schema",
         "type": "object",
         "properties": {
           "room": {
             "description": "Room to send message to",
             "type": "string"
           },
           "from": {
             "description": "Message sender",
             "type": "string"
           },
           "api_token": {
             "description": "Token to use for authentication",
             "type": "string",
             "format": "hash"
           },
           "api_version": {
             "description": "Version of hipchat api to use",
             "type": "string",
             "enum": [
               "1",
               "2"
             ]
           },
           "color": {
             "description": "Displayed message color in hipchat window",
             "type": "string",
             "enum": [
               "yellow",
                "red",
               "green",
               "purple",
               "gray",
               "random"
             ]
           },
           "notify": {
             "description": "Used to notify the room of the message...",
               "type": "string",
               "enum": [
                 "0",
                 "1"
               ]
             }
           },
           "required": [
             "template",
             "room",
             "api_token"
           ]
        },
       "http": {
         "description": "Notifier - HTTP (with auth) schema",
         "type": "object",
         "properties": {
           "url": {
             "description": "Url to send message to",
               "type": "string",
               "format": "url"
           },
           "auth": {
             "description": "Auth details",
             "type": "object",
             "properties": {
               "type": {
                 "description": "Authentication type",
                 "type": "string",
                 "enum": [
                   "basic"
                 ]
               },
               "username": {
                 "description": "Username to authenticate with",
                 "type": "string"
               },
               "password": {
                 "description": "Password to authenticate with",
                 "type": "string"
               }
             }
           }
         },
         "required": [ "url" ]
       }
     }
   }

   
**Response**

The response will return the |json| for the updated alias.

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``204``
     - Success.
