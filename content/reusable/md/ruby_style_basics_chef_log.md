`Chef::Log` will print log entries to the default logger that is configured for the machine on which Chef Infra Client is running. (To create a log entry that is built into the resource collection, use the [log resource](/resources/log/) instead of `Chef::Log`.)

<!-- markdownlint-disable-file MD002 -->

### Supported log levels

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Log Level</th>
<th>Syntax</th>
</tr>
</thead>
<tbody>
<tr>
<td>Fatal</td>
<td><code>Chef::Log.fatal('string')</code></td>
</tr>
<tr>
<td>Error</td>
<td><code>Chef::Log.error('string')</code></td>
</tr>
<tr>
<td>Warn</td>
<td><code>Chef::Log.warn('string')</code></td>
</tr>
<tr>
<td>Info</td>
<td><code>Chef::Log.info('string')</code></td>
</tr>
<tr>
<td>Debug</td>
<td><code>Chef::Log.debug('string')</code></td>
</tr>
</tbody>
</table>
