There are three types of handlers:

exception

: An exception handler is used to identify situations that have caused a Chef Infra Client run to fail. An exception handler can be loaded at the start of a Chef Infra Client run by adding a recipe that contains the **chef_handler** resource to a node's run-list. An exception handler runs when the `failed?` property for the `run_status` object returns `true`.

report

: A report handler is used when a Chef Infra Client run succeeds and reports back on certain details about that Chef Infra Client run. A report handler can be loaded at the start of a Chef Infra Client run by adding a recipe that contains the **chef_handler** resource to a node's run-list. A report handler runs when the `success?` property for the `run_status` object returns `true`.

start

: A start handler is used to run events at the beginning of a Chef Infra Client run. A start handler can be loaded at the start of a Chef Infra Client run by adding the start handler to the `start_handlers` setting in the client.rb file or by installing the gem that contains the start handler by using the **chef_gem** resource in a recipe in the **chef-client** cookbook. (A start handler may not be loaded using the `chef_handler` resource.)