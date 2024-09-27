+++
title = "Writing Procedures"
draft = false
gh_repo = "chef-web-docs"


[menu]
  [menu.overview]
    title = "Procedures"
    identifier = "overview/style/formatting/procedures"
    parent = "overview/style/formatting"
+++

This page provides guidance for writing procedures.

Every set of procedures has four elements: a [title or heading](#titles-and-headings), an [introduction](#introduction), the [step-by-step procedures](#writing-steps), and an [end point](#end-point).

## Titles and headings

The title or heading should briefly explain what the procedure will accomplish.

Use the [bare infinitive](https://en.wikipedia.org/wiki/Infinitive#English) to form titles or headings for a set of procedures.
Avoid using the _-ing_ form of a verb, either a [gerund](https://en.wikipedia.org/wiki/Gerund#Gerunds_in_English) or the [present participle](https://en.wikipedia.org/wiki/Participle#Modern_English).

Use [sentence case](https://en.wikipedia.org/wiki/Letter_case#Sentence_case) for section headings and page titles.

{{< recommend >}}

Install the Chef Habitat CLI

{{< /recommend >}}

{{< recommend >}}

Create an instance

{{< /recommend >}}

{{< recommend not >}}

Installing the Chef Habitat CLI

{{< /recommend >}}

{{< recommend not >}}

Run these steps on the node.

{{< /recommend >}}

## Introduction

The introduction provides preliminary information that a user needs in order to follow a set of procedures.

Each introduction will be unique, but may contain the following information:

- **Why a task should be completed**.

  It may not be clear why a user should perform a set of procedures. If it's not clear, explain what the benefit is or what the outcome will be.

- **When a task should be completed**.

  Are there routine tasks that should be completed on regular basis? For example, performing a system backup or certificate rotation.
  Should a set of procedures be performed after another event? For example, after a software upgrade.

- **What safety measures should be completed before starting a set of procedures**.

  Do they need to back up data before they start a set of procedures? Is there a security risk?

- **How long will it take to complete a set of procedures**.

  This is particularly important if a set of procedures will take a long time to complete.
  If users will spend several hours completing a task, they need to know in advance.
  This is also important if users have critical systems that might be down for an extended period of time.

## Prerequisites

A set or procedures may require certain hardware or software, or certain permissions or access to complete a set of procedures.
Include those requirements before a set of procedures.

If users will install third-party software, include links the system requirement documentation for that software.

## Writing steps

### Procedure levels

Procedures should be written at the highest level that the user will understand.

The lowest level of a set of procedures might tell a user to enter their username, then enter their password, then click on the Sign In button.
A higher level would tell users to log into an account.
Both of these levels achieve the same goal, logging a user into an account, but the lower level splits the procedure into several smaller steps.
This lower level is too low for must users and certainly too low for Chef's users.

Higher level tasks give the user a better overview of the procedures and where they are while following a set of procedures.
Higher level tasks are also less likely to become obsolete when a product is updated.

It's important to understand the users' skill level so steps can be written at the correct level.

### Each step is an action

Each step is an action that a user will perform or a decision that a user must make.
If an action triggers a response from an application or a system, that response is not a step.

Use an [imperative verb](https://en.wikipedia.org/wiki/Imperative_mood#English) in the first sentence of every step to clarify the action that the user will take. Format each step as a separate ordered list item.

{{< recommend >}}

1. Select **Submit**.

   A dialog box opens with a "Success" message.

{{< /recommend >}}

{{< recommend >}}

1. Select **Submit** and a dialog box opens with a "Success" message.

{{< /recommend >}}

{{< recommend not >}}

1. Select **Submit**.
1. A dialog box opens with a "Success" message.

{{< /recommend >}}

### Components in a step

Many steps only require a description of the action that a user will take.
However, users may require additional information to complete or understand a step.

Use the following order to describe each component of a step:

1. Describe the action that the user will take.
1. Show the command they will run or the text they will add or update, if necessary.
1. Explain any placeholders in the command, if necessary.
1. Explain the command in detail, if necessary.
1. Show the command output, if necessary.
1. In a separate paragraph, explain the significance of the output, if necessary.

For example:

1. Restart the service on the Chef Infra Server.

   ```bash
   chef-server-ctl restart <SERVICE_NAME>
   ```

   Replace `<SERVICE_NAME>` with the name of the service you are restarting.

   The `chef-server-ctl restart` subcommand restarts all services on the Chef Infra Server or a single service if you specify a service name.

   When the service restarts, it returns:

   ```sh
   ok: run: service_name: (pid 12345) 1s
   ```

   The output above shows that the service has restarted correctly.

### Group related actions

If possible, group long sets of steps into multiple groups.

It can be mind numbing for a user to go from one step to another to another over a long set of procedures without an ending point.
Group long sets of procedures into subgroups. This adds a functional level that keeps users oriented as they complete each set of tasks.

{{< recommend not >}}

Update the `config.toml` file to configure the node.

1. Do the first thing to configure the server
1. Do the second thing to configure the server
1. Do the third thing to configure the server
1. Do the fourth thing to configure the node
1. Do the fifth thing to configure the node
1. Do the sixth thing to configure the node
1. Do the seventh thing to configure the node

{{< /recommend >}}

{{< recommend >}}

Update the `config.toml` file to configure the node.

1. Configure the server.
   1. Do the first thing
   1. Do the second thing
   1. Do the third thing
1. Configure the node.
   1. Do the first thing
   1. Do the second thing
   1. Do the third thing
   1. Do the fourth thing

{{< /recommend >}}

### Optional steps

Preface optional instructions with _Optional:_ before each step.

{{< recommend >}}

1. Optional: Override any default build phases you need using callbacks.

{{< /recommend >}}

### Conditional steps

Preface conditional steps with the condition.

Conditional steps should begin with _If_.
Users rarely read ahead when reading a set of instructions, so if the condition is placed at the end of a step, they may perform the action before realizing that it doesn't apply to them.

{{< recommend not >}}

1. Reindex all organizations if the test is successful.

{{< /recommend >}}

{{< recommend >}}

1. If the test is successful, reindex all organizations.

{{< /recommend >}}

### Single-step procedures

Use an unordered list item for single-step procedures.

{{< recommend >}}

- To cleanse the node, run `chef-backend-ctl cleanse`.

{{< /recommend >}}

{{< recommend not >}}

To cleanse the node, run this command:

1. `chef-backend-ctl cleanse`

{{< /recommend >}}

{{< recommend not >}}

Cleanse the node.

1. `chef-backend-ctl cleanse`

{{< /recommend >}}

{{< recommend not >}}

To cleanse the node, run this command:

- `chef-backend-ctl cleanse`

{{< /recommend >}}

## End point

Every set of procedures has an _end point_, which is the state of a system after completing a set of procedures.
This may be a midway point in a long set of procedures, or the conclusion of a set of procedures.

When a user reaches an end point, they should intuitively know or be able to verify that they've reached the end point.
If it's not clear, include a picture of a user interface, a CLI output, a command that a user can run to verify that a system or application is running, or the description of a file detailing its completed state.

## General guidelines

### Test procedures

Test procedures from beginning to end while writing them.

It's difficult to evaluate the quality of a set of instruction unless you run through them and perform the tasks while you're writing them.
Someone else should also test the procedures after they're written. This could be another writer, someone in customer support, or potentially a customer.

### Use the imperative mood or indicative mood

Write all instructions using the imperative or indicative moods.

The [imperative mood](https://en.wikipedia.org/wiki/Imperative_mood#Usage) tells the user to do something.

{{< recommend >}}
Open the config file.
{{< /recommend >}}

The [indicative mood](https://en.wikipedia.org/wiki/Realis_mood#The_English_indicative) states facts.

{{< recommend >}}
The config file specifies settings for the server.
{{< /recommend >}}

### Avoid passive voice

[Passive voice](https://en.wikipedia.org/wiki/Passive_voice#In_English) is often vague and it can be unclear who or what is performing an action.

{{< recommend not >}}

The node is updated.

{{< /recommend >}}

{{< recommend not >}}

The node is updated by the server.

{{< /recommend >}}

{{< recommend >}}

The server updates the node.

{{< /recommend >}}

### Don't use _should_

Don't use the words _should_, _could_, and _would_.
They create ambiguity and could cause confusion over whether you're making a recommendation or stating a requirement.
If you write, "You should back up the server," is that a requirement or a suggestion?

{{< recommend not >}}
The config file should be opened.
{{< /recommend >}}

{{< recommend not >}}
You should back up the server.
{{< /recommend >}}

{{< recommend >}}
Back up the server.
{{< /recommend >}}

If a user must perform a task, use _must_.

{{< recommend >}}
You must back up the server before upgrading.
{{< /recommend >}}

If something will happen as the result of a user action, don't use _should_, just say what will happen.

{{< recommend not >}}
After you run the command, the notification should appear.
{{< /recommend >}}

{{< recommend >}}
After you run the command, the notification appears.
{{< /recommend >}}

### Don't use _please_

We're not trying to win an etiquette contest. Just tell the user what to do in simple clear text.

{{< recommend not >}}
Please back up the node before upgrading.
{{< /recommend >}}

{{< recommend >}}
Before upgrading, back up the node.
{{< /recommend >}}

### Don't use _we_ when referring to the user

_We_ are not doing anything. The user is doing something so use _you_ if you must, but it's better to use the implied _you_ in the [imperative mood](https://en.wikipedia.org/wiki/Imperative_mood#Usage) .

{{< recommend not >}}

We can now verify that the node is running.

{{< /recommend >}}

_You_ is better, but try to avoid it if possible.

{{< recommend >}}

You can now verify that the node is running.

{{< /recommend >}}

If this is a step that the user must perform, try using the [imperative mood](https://en.wikipedia.org/wiki/Imperative_mood#Usage) . It's simpler, shorter, and more direct.

{{< recommend >}}

Verify that the node is running.

{{< /recommend >}}

### Use an ordered list to document steps

Use an ordered list to document steps. The exception is if there is only [one step in a set of procedures](#single-step-procedures).

{{< recommend not >}}

- Check the system status.
- Back up the data.

{{< /recommend >}}

{{< recommend >}}

1. Check the system status.
1. Back up the data.

{{< /recommend >}}

{{< note >}}

Hugo automatically renders an ordered list in Markdown into the correct numerical order in HTML, so all you have to do is preface each step with `1.`. This makes it easier to add, reorder, or delete steps later. For example:

```md
1. The first step.
1. The second step.
1. The third step.
```

produces:

1. The first step.
1. The second step.
1. The third step.

{{< /note >}}

### Avoid using the phrase "Run the following command"

Focus on what the user is doing, then show the command that the user will execute in a code example.

{{< recommend not >}}

1. Run the following command.

   ```sh
   chef-backend-ctl backup
   ```

{{< /recommend >}}

{{< recommend not >}}

1. Run the `chef-backend-ctl backup` command.

   ```sh
   chef-backend-ctl backup
   ```

{{< /recommend >}}

{{< recommend >}}

1. Back up the data on the node.

   ```sh
   chef-backend-ctl backup
   ```

{{< /recommend >}}

### Present tense

In general, you can omit the word _will_ and use the present tense rather than the future tense to describe user actions and system responses.
Users perform actions in real time as they read through the instructions, so from the user's perspective, actions and system responses happen in the present.

{{< recommend not >}}

The command will open the user interface.

{{< /recommend >}}

{{< recommend >}}

The command opens the user interface.

{{< /recommend >}}

Reserve the future tense and _will_ for events that happen in the future from the user's perspective.

{{< recommend >}}

The node will query the server at the specified interval.

{{< /recommend >}}
