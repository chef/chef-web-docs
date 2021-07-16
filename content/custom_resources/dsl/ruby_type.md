The property ruby_type is a positional parameter.

Use to ensure a property value is of a particular ruby class, such as `true`, `false`, `nil`, `String`, `Array`, `Hash`, `Integer`, `Symbol`. Use an array of
Ruby classes to allow a value to be of more than one type. For example:

```ruby
property :aaaa, String
property :bbbb, Integer
property :cccc, Hash
property :dddd, [true, false]
property :eeee, [String, nil]
property :ffff, [Class, String, Symbol]
property :gggg, [Array, Hash]
```
