The syntax for using the **machine_execute** resource in a recipe is as
follows:

``` ruby
machine_execute 'name' do
  attribute 'value' # see properties section below
  ...
  action :action # see actions section below
end
```

where

-   `machine_execute` tells Chef Infra Client to use the
    `Chef::Provider::MachineExecute` provider during a Chef Infra Client
    run
-   `name` is the name of the resource block; when the `command`
    property is not specified as part of a recipe, `name` is also the
    command to be run
-   `attribute` is zero (or more) of the properties that are available
    for this resource
-   `action` identifies which steps Chef Infra Client will take to bring
    the node into the desired state