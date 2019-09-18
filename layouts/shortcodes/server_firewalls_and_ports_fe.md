For front-end servers, ensure that ports marked as external (marked as
`yes` in the **External** column) are open and accessible via any
firewalls that are in use:

<table>
<colgroup>
<col style="width: 11%" />
<col style="width: 77%" />
<col style="width: 11%" />
</colgroup>
<thead>
<tr class="header">
<th>Port</th>
<th>Service Name, Description</th>
<th>External</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>80, 443, 9683</td>
<td><strong>nginx</strong></td>
<td></td>
</tr>
</tbody>
</table>

{{ readFile "layouts/shortcodes/server_services_nginx.md" | markdownify }}

> <div class="note" markdown="1">
>
> <div class="admonition-title" markdown="1">
>
> Note
>
> </div>
>
> Port 9683 is used to internally load balance the **oc_bifrost**
> service.
>
> </div>

> -   yes

> -   -   9463
>     -   **oc_bifrost**
>
{{ readFile "layouts/shortcodes/server_services_bifrost.md" | markdownify }}

> -   

> -   -   9090
>     -   **oc-id**
>
{{ readFile "layouts/shortcodes/server_services_oc_id.md" | markdownify }}

> -   

> -   -   8000
>     -   **opscode-erchef**
>
{{ readFile "layouts/shortcodes/server_services_erchef.md" | markdownify }}

> -   