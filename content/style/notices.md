+++
title = "Notices"
draft = false
gh_repo = "chef-web-docs"

[menu]
  [menu.overview]
    title = "Notices"
    identifier = "overview/style/formatting/notices"
    parent = "overview/style/formatting"
+++

This document provides guidance on when and how to create note, warning, and danger notices in documentation.

In general, notes, warnings, and admonitions aren't the best way to present important information.
Before using them, ask yourself how important the information is.
If you want the information to be returned in a search result, then it's better for the information to have its own topic or section heading.

Note, warning, and danger notice boxes have a different color than the surrounding text so they can be spotted within a document.
If you must use a note or warning, bracket the text of the note or warning in a **note**, **warning**, or **danger** shortcode.

## Notes

A note adds useful but not essential information.
This may include information that makes a task easier or provides a shortcut to completing a task more quickly.
There's no danger or risk to a system if a note is ignored.

Add a note using the note shortcode:

```md
{{</* note */>}}

This is the text of a note.

{{</* /note */>}}
```

## Warnings

A warning is a more serious prompt that tells the user to proceed carefully.
Use warnings sparingly so that when the user sees a warning it registers appropriately.

```md
{{</* warning */>}}

This is text in a warning.

{{</* /warning */>}}
```

## Danger

Danger notices should be used when there are serious consequences for the user or their system.
If a user ignores a danger notice, they may lose data, money, work, or expose themselves to a security vulnerability.

**Use a danger notice only if it's necessary.**

When writing text in a danger notice, use short direct language and be specific about what will happen if someone ignores a danger notice.

```md
{{</* danger */>}}

This is text in a danger notice.

{{</* /danger */>}}
```

## Beta

Add a beta notice to alert users to beta features or products. Include links to any supporting information and add advice about contacting support before implementing a beta feature. Place this notice at the top of a page before any other text.

```md
{{</* beta */>}}

This is text in a beta notice.

{{</* /beta */>}}
```
