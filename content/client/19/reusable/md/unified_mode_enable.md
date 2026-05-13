Unified Mode is enabled by default starting in Chef Infra Client 18.

In Chef Infra Client 17 (April 2021) and some earlier versions, you can enable Unified Mode in custom resources by adding `unified_mode true`. You can upgrade most custom resources to use Unified Mode without additional work other than testing and validation. See the following example:

```ruby
# enable unified mode
unified_mode true

provides :myresource

actions :run do
  [...]
end
```
