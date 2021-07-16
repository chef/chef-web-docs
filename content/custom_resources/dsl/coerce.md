`coerce` is used to transform user input into a canonical form. The
value is passed in, and the transformed value returned as output. Lazy
values will **not** be passed to this method until after they are
evaluated.

`coerce` is run in the context of the instance, which gives it access to
other properties.

Here we transform,`true`/`false` in to `yes`, `no` for a template later on.

```ruby
property :browseable,
        [true, false, String],
        default: true,
        coerce: proc { |p| p ? 'yes' : 'no' },
```

If you are modifying the properties type, you will also need to accept that Ruby type as an input.
