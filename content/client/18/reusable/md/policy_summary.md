Policy maps business and operational requirements, process, and workflow
to the following settings and objects stored on Chef Infra Server:

- Roles define server types, such as _web server_ or _database server_.
- Environments define process, such as _dev_, _staging_, or _production_.
- Attributes define environment-specific details about a node that are included in a Policyfile.
- Certain types of data---passwords, user account data, and other
    sensitive items---can be placed in data bags, which are located in a
    secure sub-area on Chef Infra Server that can only be accessed
    by nodes that authenticate to Chef Infra Server with the correct
    SSL certificates.
- The cookbooks (and cookbook versions) in which organization-specific
    configuration policies are maintained.
