+++
title = "Create an account"
description = "Create a SaaS Builder account"
summary = "Create an account to manage origins and packages"


[menu.habitat]
    title = "Create an account"
    identifier = "habitat/builder/saas/Builder Account"
    parent = "habitat/builder/saas"
    weight = 20

+++

Whether you are looking to leverage the SaaS or on-prem version of Chef Habitat Builder, you'll need to create an account on Chef Habitat SaaS Builder. After you've deployed Habitat On-Prem Builder, you'll sync the two using your SaaS and On-prem accounts.

## Prerequisites

You need to set a few things up before you can get started with Chef Habitat Builder:

- download and install the [Chef Habitat CLI](/install/)
- a [GitHub account](https://github.com/join)
- a Progress Chef license

## Sign-in and authorize Chef Habitat Builder

Chef Habitat Builder automatically creates your account the first time you sign in using the GitHub authentication process. You'll also need to authorize the Chef Habitat Builder application in Github.

Head over to the Chef Habitat Builder sign-in page at [https://bldr.habitat.sh/#/sign-in](https://bldr.habitat.sh/#/sign-in) to get started.

1. To sign in with an existing GitHub account, select **Sign in with GitHub**
1. If you need to set up a GitHub account, select the **Sign up here** link

![Chef Habitat sign in with Github](/images/habitat/builder_sign_in.png)

Signing in with your GitHub account and authorizing the Chef Habitat Builder application the first time you sign in grants you access to the Chef Habitat Builder platform. Once you've completed signing in and authorizing Chef Habitat Builder, you'll arrive at the **My Origins** view.

{{< figure src="/images/habitat/authorize.png" alt="Chef Habitat and GitHub authorization screen." width="500px" >}}