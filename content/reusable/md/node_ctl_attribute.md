Any other attribute type that's contained in this JSON file will be
treated as a `normal` attribute. Setting attributes at other precedence
levels isn't possible. For example, attempting to update `override`
attributes using the `-j` option:

```json
{
  "name": "dev-99",
  "description": "Install some stuff",
  "override_attributes": {
    "apptastic": {
      "enable_apptastic": "false",
      "apptastic_tier_name": "dev-99.bomb.com"
    }
  }
}
```

will result in a node object similar to:

```json
{
  "name": "maybe-dev-99",
  "normal": {
    "name": "dev-99",
    "description": "Install some stuff",
    "override_attributes": {
      "apptastic": {
        "enable_apptastic": "false",
        "apptastic_tier_name": "dev-99.bomb.com"
      }
    }
  }
}
```

<!-- Delete Used once in chef-workstation -->