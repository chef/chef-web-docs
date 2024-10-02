Enable Unified Mode by adding the `unified_mode true` in a custom resource. You can upgrade most custom resources to use Unified Mode without additional work other than testing and validation.

```ruby
# enable unified mode
unified_mode true

provides :myresource

actions :run do
  [...]
end
```
