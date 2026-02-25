The fontawesome shortcode will display any free [Font Awesome icon](https://fontawesome.com/icons) in a page.

It accepts the following parameters:

- `background-color`
- `border`
- `border-radius`
- `class`
- `color`
- `font-size`
- `margin`
- `padding`

The only required parameter is `class`, which is the same as the class name of the icon.

The following shortcode examples will display these icons: {{< fontawesome class="fas fa-ellipsis-h">}} {{< fontawesome class="fas fa-anchor" font-size="3rem" border="2px dashed" padding="1px" border-radius="5px">}} {{< fontawesome class="fas fa-archive" color="#cc814b" margin="0 0 0 12px">}} {{< fontawesome class="far fa-address-book" background-color="DarkBlue" color="rgb(168, 218, 220)">}}

```markdown
{{</* fontawesome class="fas fa-ellipsis-h" */>}}
{{</* fontawesome class="fas fa-anchor" font-size="3rem" border="2px dashed" padding="1px" border-radius="5px" */>}}
{{</* fontawesome class="fas fa-archive" color="#cc814b" margin="0 0 0 12px"*/>}}
{{</* fontawesome class="far fa-address-book" background-color="DarkBlue" color="rgb(168, 218, 220)" */>}}
```
