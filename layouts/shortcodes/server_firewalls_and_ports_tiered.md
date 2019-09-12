For back-end servers in a tiered Chef Infra Server installation, ensure
that ports marked as external (marked as `yes` in the **External**
column) are open and accessible via any firewalls that are in use:

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

> -   -   8983
>     -   **opscode-solr4**
>
{{ readFile "layouts/shortcodes/server_services_solr4.md" | markdownify }}

> -   

> -   -   5432
>     -   **postgresql**
>
{{ readFile "layouts/shortcodes/server_services_postgresql.md" | markdownify }}

> -   

> -   -   5672, 15672
>     -   **rabbitmq**
>
{{ readFile "layouts/shortcodes/server_services_rabbitmq.md" | markdownify }}

> -   

> -   -   16379
>     -   **redis_lb**
>
{{ readFile "layouts/shortcodes/server_services_redis.md" | markdownify }}

> -   

> -   -   4321
>     -   **bookshelf**
>
{{ readFile "layouts/shortcodes/server_services_bookshelf.md" | markdownify }}

> -   

> -   -   8000
>     -   **opscode-erchef**
>
{{ readFile "layouts/shortcodes/server_services_erchef.md" | markdownify }}

> -   