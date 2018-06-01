# Documenting with dtags

`dtags` is an approach to structured documentation that works well
with modern version control systems like `git` and overcomes the
usability problems of nested include files.

## Why include files hurt documentation

Reusing content makes sense when you're building large, structured
documentation sets. A summary paragraph about a product feature might
need to appear in multiple places. Or, you might want to put
information about methods of a base class in the documentation for
each of the derived classes.

Most documentation systems achieve content reuse with "include"
files. In the Sphinx documentation generator for restructuredText
there is a directive `.. include::` to bring in shared content from
another file. Here's an example:

`A.rst`

```rst
   Foo
   =======================================

   Let's introduce **Foo**.

   .. include ../../includes/foo_summary.rst

   As mentioned above, **Foo** is a powerful feature of our product.
```

The file `../../includes/foo_summary.rst` contains the reusable content:

```rst
**Foo** does lots of things.
```

Of course, the whole point is that `../../includes/foo_summary.rst`
can appear in lots of places, for example, in `B.rst`:

`B.rst`

```rst
   **Enterprise Foo** is based on Foo.

   .. include ../../includes/foo_summary.rst

   But as impressive as **Foo** is, **Enterprise Foo** does even more.
```

Using include files for structured content starts innocently enough.

It quickly becomes difficult. Include files can themselves be included
in other include files. The number of include statements can
proliferate to the point of being unmanageable. If you make a change
to an include file, it can be very tricky to figure out what the
consequences of that change might be.

Systems for structured content that are based on include files were
originally created with the assumption that a dedicated team of
documentation professionals created and edited all of the
content. That assumption isn't true anymore. With large open source
projects and agile software development practices, a much larger
number of people contribute directly to documentation
projects. Include files make it hard for this broader set of
contributors to engage.

TL;DR. Include files get out of hand quickly and can make the entire
process of writing and maintaining structured documentation very
hard.

## Keep reusable text but get rid of include files 

We think the solution is to get rid of include files but keep the idea
of structured, shared content. All that's needed is a bit of tooling
to make it practical to manage the shared blocks of text inline.

Our tool is called `dtags` and it gets rid of include files but
retains the ability to reuse content.

All you need to do is maintain inline comments that tag regions of
content as being reused. The restructuredText from the previous
example becomes:

`A.rst`

```rst
   Foo
   =======================================

   Let's introduce **Foo**.

   .. tag foo_summary

   **Foo** does lots of things.

   .. end_tag

   As mentioned above, **Foo** is a powerful feature of our product.
```

and

`B.rst`

```rst
   **Enterprise Foo** is based on Foo.

   .. tag foo_summary

   **Foo** does lots of things.

   .. end_tag

   But as impressive as **Foo** is, **Enterprise Foo** does even more.
```

Include files like `../../includes/foo_summary.rst` go away.

How do we keep the tagged regions in sync? They are, after all, in two
source files at the same time, and it's not reasonable to require
manual edits to multiple files when making what is conceptually a
single change.

This turns out not to be a hard problem. It's the kind of problem
that computers are very good at.

What also makes the problem easy is that nowadays we use version
control systems like `git` and workflow automation from systems like
GitHub and Chef Automate. It's possible to make consistency of shared
regions an automatically enforced condition of the merge into the
master branch. A user can safely experiment with tool-generated
changes to content without endangering the changes they've made by
hand but have not yet published.

To understand how this works, let's look at the `dtags` workflow.

## Suggested workflow

Continuing with the example of `A.rst` and `B.rst` that share one
region of text using the `foo_summary` tag, suppose that we decide to
update the shared text. We can do this by editing either file, but
let's say that `A.rst` is the one that we want to work on. Here's our
change:

`A.rst`

```rst
   Foo
   =======================================

   Let's introduce **Foo**.

   .. tag foo_summary

   **Foo** does lots of really important things and it does them fast.

   .. end_tag

   As mentioned above, **Foo** is a powerful feature of our product.
```

Our version control system sees the change:

```bash
git status
On branch master
Your branch is up-to-date with 'origin/master'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

  modified:   A.rst
```

We can review the change by looking at diffs.

```bash
git diff
diff --git a/src/examples/A.rst b/src/examples/A.rst
 index 8e7ea54..3d5a97a 100644
 --- a/src/examples/A.rst
 +++ b/src/examples/A.rst
 @@ -5,7 +5,7 @@

    .. tag foo_summary

-   **Foo** does lots of things.
+   **Foo** does lots of really important things and it does them fast.

    .. end_tag
```

We can also build the HTML output and check that it's what we want. 

When we're satisfied with our change locally, we can check its impact
on other parts of the documentation. By the way, we had this same
obligation under the old system of include files, except we had no
practical way of doing it! In many cases, people just changed the
include file and hoped for the best.

With `dtags` the first step would be to put our changes into a safe
location. We can do this by adding our change to the git index, the
staging area for changes prior to commiting them. The `git add`
command is what we want.

```bash
git add A.rst
git status

On branch master
Your branch is up-to-date with 'origin/master'.

Changes to be committed:
 (use "git reset HEAD <file>..." to unstage)
modified:   A.rst
```

Now we're ready to use `dtags` to analyze the impact of changes to
shared content and to replicate changes.

We start by running the `dtags check` subcommand.

```bash
dtags check
Inconsistent tagged regions:
  foo_summary e8ae754 A.rst:6

  foo_summary 5a93da7 B.rst:3
```

The `dtags` tool compares the tags across the doc set (the current working
directory) and reports inconsistencies.

The output gives a hash digest of each tagged region, as well as the
file name and line number where the tag is seen.

We can apply the changes to all or part of the documentation set
in our working set with the `dtags replicate` subcommand.

```bash
dtags replicate foo_summary A.rst

  tag foo_summary 5a93da7 -> e8ae754 B.rst:3
```

Typing `dtags replicate foo_summary A.rst` had the effect of
propagating the `foo_summary` tagged region found in the `A.rst`
file to the rest of the source files in the doc set. (There are other
options for using `dtags replicate`.)

We can check that a change was made by looking at the `git status`.

```bash
git status
On branch master
Your branch is up-to-date with 'origin/master'.

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

  modified:   A.rst

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

  modified:   B.rst

```

This tells us that `A.rst` is still safely tucked away in the index
and `B.rst` has been modified. We say "safely" because if we had
made a mistake with the `dtags` tool and modified `A.rst` by
accident, the edits we had made by hand would still be safe.

For example, let's say that we had mistakenly replicated `B.rst`'s
version of the `foo_summary` tagged region.

```
dtags replicate foo_summary B.rst

  tag foo_summary e8ae754 -> 5a93da7 A.rst:6
```

Oops, we just overwrote our changes with the old text! This isn't a
problem. We can fix that glitch by "unstaging" `A.rst` and putting
`A.rst` back in the index:

```bash
git reset HEAD A.rst
git add A.rst
dtags replicate -- A.rst
```

All fixed! The `--` value is a placeholder that says to replicate all
tags found in the given topic.

The final step is to make sure all of the tagged regions are
consistent and commit our changes and push them to the repo used for
the project.

```bash
dtags check
git add B.rst
git commit -m "Changed foo_summary per VP of Marketing"
git push
```

`dtags` and `git` work together and make it possible for people who
make changes to shared content blocks to analyze and replicate the
changes they make.

Next, we suggest that you look over the [`dtags` help page](dtags_help.md).
