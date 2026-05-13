A run-list must be in one of the following formats: fully qualified,
cookbook, or default. Both roles and recipes must be in quotes, for
example:

```json
"role[NAME]"
```

or

```json
"recipe[COOKBOOK::RECIPE]"
```

Use a comma to separate roles and recipes when adding more than one item
the run-list:

```json
"recipe[COOKBOOK::RECIPE],COOKBOOK::RECIPE,role[NAME]"
```
