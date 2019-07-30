A **dsc_resource** resource block allows DSC resources to be used in a
Chef recipe. For example, the DSC `Archive` resource:

``` powershell
Archive ExampleArchive {
  Ensure = "Present"
  Path = "C:\Users\Public\Documents\example.zip"
  Destination = "C:\Users\Public\Documents\ExtractionPath"
}
```

and then the same **dsc_resource** with Chef:

``` ruby
dsc_resource 'example' do
   resource :archive
   property :ensure, 'Present'
   property :path, "C:\Users\Public\Documents\example.zip"
   property :destination, "C:\Users\Public\Documents\ExtractionPath"
 end
```

The full syntax for all of the properties that are available to the
**dsc_resource** resource is:

``` ruby
dsc_resource 'name' do
  module_name                String
  module_version             String
  property                   Symbol
  reboot_action              Symbol # default value: :nothing
  resource                   Symbol
  timeout                    Integer
  action                     Symbol # defaults to :run if not specified
end
```

where:

-   `dsc_resource` is the resource.
-   `name` is the name given to the resource block.
-   `action` identifies which steps Chef Infra Client will take to bring
    the node into the desired state.
-   `property` is zero (or more) properties in the DSC resource, where
    each property is entered on a separate line, `:dsc_property_name` is
    the case-insensitive name of that property, and `"property_value"`
    is a Ruby value to be applied by Chef Infra Client
-   `module_name`, `module_version`, `property`, `reboot_action`,
    `resource`, and `timeout` are properties of this resource, with the
    Ruby type shown. See "Properties" section below for more information
    about all of the properties that may be used with this resource.