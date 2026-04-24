---
name: review-release-notes
description: 'Read a release notes file, fetch each referenced GitHub pull request using the GitHub MCP server, and edit each note based on the actual PR changes. Optionally fetch a Jira epic using the Atlassian MCP server to provide additional context. Triggers on: review release notes, update release notes, fix release notes, release notes from PRs, release notes from pull requests, release notes from Jira, sync release notes, edit release notes.'
argument-hint: "Path to the release notes file — for example: docs/release-notes.md. Optionally add a Jira epic key to use as context: docs/release-notes.md PLATFORM-123"
---

# Review and edit release notes from pull requests

Runs a four-stage workflow to review a release notes file, enrich each note with
information from the referenced GitHub pull requests, and optionally align entries with
a Jira epic.

1. **Parse** — reads the release notes file and extracts every PR reference
2. **Fetch PRs** — uses the GitHub MCP server to retrieve the title, body, and linked
   issues for each referenced PR
3. **Fetch Jira epic** (optional) — uses the Atlassian MCP server to retrieve epic
   details, child issues, and acceptance criteria
4. **Edit** — rewrites each release note to accurately reflect the PR changes and any
   Jira context, then applies the team style guide

---

## What to ask the user

Before starting, confirm these inputs if not already provided:

1. **Release notes file path** — the path to the Markdown file to review, for example:
   `docs/release-notes/v2.4.md`

2. **GitHub repository** — the `owner/repo` the PRs belong to, for example:
   `chef/chef-infra-client`.
   Skip this if every PR reference is a full URL (for example,
   `https://github.com/chef/chef-infra-client/pull/123`).

3. **Jira epic key** (optional) — a Jira epic key to use as additional context when
   editing notes, for example: `PLATFORM-456`.
   If not provided, skip Stage 3 entirely.

---

## Stage 1: Parse the release notes file

Read the release notes file and identify every pull request reference.

PR references appear in several common forms:

| Format | Example |
|--------|---------|
| Short reference | `#123` |
| Full GitHub URL | `https://github.com/chef/chef-infra-client/pull/123` |
| Markdown link with PR number | `[#123](https://github.com/...)` |
| Markdown link with title | `[Fix node run list](https://github.com/.../pull/123)` |

For each PR reference found:

1. Extract the PR number.
2. Determine the `owner/repo`. If the reference is a short `#123`, use the repository
   the user provided. If it's a full URL, parse owner and repo from the URL.
3. Record the line number and surrounding text so you can find and edit it in Stage 4.

Build a deduplicated list of PRs to fetch. If a PR number appears more than once
(for example, referenced in multiple notes), fetch it once and reuse the result.

Report the number of PR references found before moving to Stage 2.

---

## Stage 2: Fetch pull request details from GitHub

Use the GitHub MCP server to fetch details for each PR in the list from Stage 1.

For each PR, retrieve:

- **Title** — the PR title as merged
- **Body** — the PR description, which typically includes a summary of changes, motivation,
  and testing notes
- **Linked issues** — issue numbers mentioned in the body using keywords such as
  `Closes #`, `Fixes #`, or `Resolves #`
- **Labels** — for example, `bug`, `enhancement`, `breaking change`
- **Merge status** — confirm the PR was merged; flag any that are open or closed without
  merging

Store the fetched data keyed by PR number. If a PR returns a 404 or the MCP server
returns an error, record the failure and note which release note it affects. Continue
fetching the remaining PRs.

After fetching all PRs, report:
- How many were fetched successfully
- How many failed or were not merged, and which release notes they affect

---

## Stage 3: Fetch Jira epic details (optional)

Skip this stage if the user did not provide a Jira epic key.

Use the Atlassian MCP server to fetch the epic and its child issues.

### Step 3a: Fetch the epic

Retrieve the epic by key. From the epic record, collect:

- **Summary** — the epic title
- **Description** — the epic's goal and scope
- **Status** — for example, `In Progress`, `Done`
- **Fix version(s)** — the release this epic targets

### Step 3b: Fetch child issues

Retrieve all issues linked to the epic. For each child issue, collect:

- **Key** — for example, `PLATFORM-457`
- **Summary** — the issue title
- **Issue type** — for example, `Story`, `Bug`, `Task`
- **Status** — for example, `Done`, `In Progress`
- **Description** — the acceptance criteria or problem statement

### Step 3c: Map Jira issues to PRs

Many PR bodies reference a Jira issue key (for example, `PLATFORM-457`) in their
description or title.
Cross-reference the child issues from the epic against the PR bodies fetched in Stage 2.
Build a mapping of Jira issue keys to PR numbers where a match exists.

This mapping lets Stage 4 use Jira acceptance criteria and feature descriptions to
improve the quality of individual release notes.

---

## Stage 4: Edit the release notes

Edit each release note entry using the PR data from Stage 2 and the Jira context from
Stage 3 (if available).

Apply the following guidelines when writing:

- **Release notes doc type guidelines** from
  [doc-types.instructions.md](../../instructions/doc-types.instructions.md) — use the
  release notes section for structural guidance, section order, entry format, tense rules,
  and language conventions. This is the primary reference for how release notes should be
  structured and written.
- **Team prose style guide** from
  [devops-docs-style.instructions.md](../../instructions/devops-docs-style.instructions.md)
  — apply for voice, tone, word choice, and formatting consistency.

### Editing guidelines

Work through each release note entry in the order it appears in the file.

For each entry:

1. **Read the existing note** and the PR data for the referenced PR number.

2. **Assess accuracy.** The existing note may be:
   - Accurate and complete — keep it, make only style corrections
   - Accurate but vague — expand it using PR body details
   - Inaccurate or missing key information — rewrite it
   - A placeholder (for example, "See PR #123") — replace it with a real note

3. **Draft the revised note** using the following sources in priority order:
   - PR body — the most authoritative source; use the summary and motivation sections
   - PR title — useful when the body is sparse
   - Jira issue description or acceptance criteria (if mapped in Stage 3) — use to add
     user-facing context that PR authors often omit
   - Linked issues in the PR body — can reveal the original bug report or feature request

4. **Apply these style rules**, derived from the release notes guidelines in
   [doc-types.instructions.md](../../instructions/doc-types.instructions.md):
   - Use present tense for new features and improvements: "Adds support for…",
     "Lets you…" — not "Added support for…"
   - Use past tense for bug fixes: "Fixed an issue where…",
     "Resolved a problem that caused…"
   - Don't start bug fix entries with "Fixed the bug…" — describe what the software
     now does correctly
   - Use second person: "You can now…", "Use the new… to…"
   - Use active voice and lead with user impact, not implementation detail
   - Don't reproduce the PR title verbatim if it's written for developers rather than users
   - Keep each note to one or two sentences unless the change is large enough to warrant more
   - Preserve any existing PR link; don't remove or change the linked PR number
   - Use the serial comma in lists
   - Don't start a note with "This PR…" or "This change…"
   - List the most important items in each section first

5. **Check section structure** against the release notes template in
   [doc-types.instructions.md](../../instructions/doc-types.instructions.md).
   Ensure the file uses the correct section order and omits any empty sections:
   - Breaking changes (always first, if present)
   - New features
   - New features requiring configuration updates
   - Improvements
   - Bug fixes
   - Known issues
   - Deprecated features

   If sections are missing, misordered, or need to be created based on PR content, add
   or reorder them to match the template.

5. **Flag notes that need human review** with an inline comment if:
   - The referenced PR was not merged or returned an error in Stage 2
   - The PR body is empty or too sparse to determine what changed
   - The change appears breaking (label `breaking change` or PR body says so explicitly)

   Use this format for the flag:

   ```markdown
   <!-- TODO: verify — PR #NNN could not be fetched or body is insufficient -->
   ```

### Breaking changes

If a PR is labeled `breaking change` or its body explicitly states the change is breaking:

- Move the note into a **Breaking changes** section if one exists in the file
- If no such section exists, add one immediately above the first regular change section
- Write the note to clearly explain what breaks and what users need to do

### Jira-only context

If a Jira child issue has no matching PR but its status is `Done` and a fix version
matches the release, add a note for it and flag it for review:

```markdown
<!-- TODO: verify — no PR found for PLATFORM-NNN; added from Jira epic -->
```

---

## Final summary

After editing the file, report:

- **PRs reviewed**: how many PR references were found and fetched
- **Notes updated**: how many entries were changed and a one-line description of each change
- **Notes unchanged**: how many entries needed no edits
- **Flagged for review**: list each flagged note with its PR number or Jira key and the
  reason it was flagged
- **Jira issues used**: if Stage 3 ran, how many Jira child issues contributed context
- **Breaking changes**: whether any breaking change notes were identified or moved
