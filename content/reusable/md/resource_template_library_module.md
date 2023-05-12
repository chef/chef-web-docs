A template helper module can be defined in a library. This is useful
when extensions need to be reused across recipes or to make it easier to
manage code that would otherwise be defined inline for each recipe
basis.

```ruby
template '/path/to/template.erb' do
  helpers(MyHelperModule)
end
```
