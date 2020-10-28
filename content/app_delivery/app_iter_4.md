+++
title = "App Integration"
draft = false

[menu]
  [menu.app_delivery]
    title = "Deploy"
    identifier = "app_delivery/app_guide/app_inter_4"
    parent = "app_delivery/app_guide"
    categories = ["app_delivery"]
    weight = 80
+++
[\[edit on GitHub\]](https://github.com/chef/chef-web-docs/blob/master/content/app_delivery/app_iter_4.md)

Iteration 4: Health Checks and Habitat Builder Integration

In this final interaction you'll finish up by adding a final run hook to check on the health of your application, and then begin integrating Habitat Builder.

Builder is a package distribution system that you can upload and pull your packages from. Your packages are stored under a public or private origin, and then pulled to verified systems to run by a Supervisor. When new versions of packages are available on a release channel they can be pulled and applied based on your update strategy.

Define
Run Hooks Revisited
Supporting Package Promotion

## Defining a Health Check

It's important to consider what a "healthy" application looks like, and how you could define a test that the Supervisor can run to validate that an app is deployed and running properly.

A health-check Hook is run when the HTTP API gets a request at /health, meaning you can run your Hook ad-hoc or at defined intervals to report back on the status of your application.

Like any other Hook, a health-check is simply a script. The script should return one of these values to determine the state of the app:

0- ok
1- warning
2- critical
3- unknown
any other code - failed health check with additional output taken from health-check stdout.

You can start by defining a simple check to see if you get a response when curling the application endpoint, hosted at http://localhost:{{cfg.server.port}}/sample .

Create a new file at habitat/hooks/health-check (note there is no file extension). Add this to the file:

```bash
#!/bin/sh

# define default return code as 0
rc=3

# curl localhost - 200 code is "ok"
# note you pass the path for curl as a variable, add the -s option so it executes silently, and write the output to /dev/null instead of stdout. The -w option lets us specify the output format as an http code that is then assigned to the STATUS variable after passing the application path.

STATUS=$({{pkgPathFor "core/curl"}}/bin/curl -s -o /dev/null -w '%{http_code}' http://localhost:{{cfg.server.port}}/sample/)

echo "HTTP Status Code: $STATUS"

case $STATUS in
  200)
    rc=0 ;;
  404)
    rc=1 ;;
  444)
    rc=2 ;;
  *)
    rc=3 ;;
esac

echo "healthcheck return code: $rc"
exit $rc
```

This script needs to return a status to know if the application is healthy. To start you'll simply return a "healthy" or "unknown" status. A code of 200) will be defined as healthy, and anything else will be "unknown".

The STATUS variable is set as the output of a subshell like this: `STATUS = $()` , meaning the code within the parenthesis is executed and stored as the variable. Within the parenthesis you start by using a Handlebars helper to locate the package path for curl. This is needed because curl may not be bin-linked when it's been installed, so prefixing it before the `/bin/curl` executable should locate it for us.

Next you add the`-s` option to curl to execute it silently, and pass the output to /dev/null with the `-o` option. Finally you use `-w` to set the output format to the `http_code` so you can map it's output to your desired health status. This simple check maps 200 as ok by returning 0, 404 "not found" as a warning by returning 1, and 444 "no response" as critical. Finally you pass the URL at http://localhost:{{cfg.server.port}}/sample/ .

Once you have the desired code stored inside of $STATUS, you echo the status code, then select the appropriate return code based on it's value. The return code is then echoed as well, and you run exit $rc to make sure the script ends safely.
Package

## Uploading Packages to Habitat Builder

Builder is the package store for Chef Habitat. Packages are sorted by version and release, and are grouped into origins.

Members of an origin are controlled using GitHub accounts. Packages within an origin can be public or private, and must be signed with the origin's private key for authenticity. Packages in private origins may only be seen and used by members of the origin.

### Creating an Origin

You've already created an origin and public/private keypair on your local machine. Recall that at the beginning of the guide you exported the `HAB_ORIGIN` environment variable and ran hab origin key generate to create the keypair, which is stored in `~/.hab/cache/keys/` . These keys were copied into the `/hab/cache/keys/` directory so the Supervisor could load your signed packages.

Now, you need access to a Builder instance to manage your packages. Habitat Builder can be installed on-premise, and be managed through the Chef Automate dashboard. This setup allows for added security and can be used in air-gapped environments.

However for this course you'll utilize the SaSS Builder, which is hosted and managed by Chef Software. It also has the added capability of watching an origin for changes to linked Plan files, and can automatically build these packages for you when changes to a Manifest are detected!

Head over the [https://bldr.habitat.sh/](https://bldr.habitat.sh/) and create an account by signing in with GitHub. You will then be prompted to authorize Builder to connect to your GitHub account. If you don't have a GitHub account you'll need to create one first.

Next, you'll create an origin. It's important to understand that origins are a logical construct, so you might create one for your organization, your department, a particular application, or just for yourself, as you'll do in this exercise.

To do this you'll upload your origin keys you generated earlier into Builder.

## Origin Keys and Access Tokens

To upload an origin key you'll need to set your personal access token and create an origin. First you'll grab your access token for your Builder account.

In the upper-right hand corner of the page, click your profile picture and select "Profile".

If you already have access to a token, you can simply use the same token to set up the CLI. If you've never created one, click "Generate Token" and copy the token. If you've forgotten your token, click "Regenerate Token" and store the token in a safe location. If you ever lose access to Builder from the command-line you can simply regenerate your token here.

Now you can finish setting up locally by exporting your Personal Access Token:

```bash
java-sample$ export HAB_AUTH_TOKEN=[PASTE TOKEN HERE]
``
Then, create a new origin:

```bash
java-sample$ hab origin create initials_tryhab
```

And lastly, you'll upload your origin key into Builder:

java-sample$ hab origin key upload --cache-key-path ~/.hab/cache/keys --pubfile ~/.hab/cache/keys/initials_tryhab*.pub

Uploading a Build

Now you're ready to upload your package to Builder. You should note that when deploying applications with Habitat you don't usually build the packages on the machines you will be deploying them on. You iterate on them in the Studio, and then upload the packages to a Builder instance where they can be pulled from and loaded.

[INSERT PATTERN DRAWING]

Next, upload your package with hab pkg upload:

java-sample$ source results/last_build.env
java-sample$ hab pkg upload results/$pkg_artifact
Deliver
Promoting Packages
Release Channels
Continuous Deployment
Next Steps

