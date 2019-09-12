Use the **bff_package** resource to manage packages for the AIX
platform using the installp utility. When a package is installed from a
local file, it must be added to the node using the **remote_file** or
**cookbook_file** resources.

<div class="alert-info">

A Backup File Format (BFF) package may not have a `.bff` file extension.
Chef Infra Client will still identify the correct provider to use based
on the platform, regardless of the file extension.

</div>