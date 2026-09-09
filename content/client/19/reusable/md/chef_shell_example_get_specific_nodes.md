To get a list of nodes using a recipe named `postfix` use
`search(:node,"recipe:postfix")`. To get a list of nodes using a
sub-recipe named `delivery`, use chef-shell. For example:

```ruby
search(:node, 'recipes:postfix\:\:delivery')
```

**Note**: Use single quotes (`' '`), not double quotes (`" "`), around the search query.
Ruby treats single-quoted strings literally, so the backslashes stay in the string.
In a double-quoted string, Ruby would interpret each backslash as the start of an escape sequence and remove it.
