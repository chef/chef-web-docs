---
name: review-release-notes
description: 'Read a release notes file and edit it using Jira release data and GitHub pull requests as co-equal, optional sources. If entries are already drafted, review and improve them using the available source data; if not, add new sections. If no sources are provided, edit the file for style and structure only. Uses read-only Atlassian and GitHub MCP operations. Never create, update, or delete anything in GitHub or Jira. Triggers on: review release notes, update release notes, fix release notes, release notes from PRs, release notes from pull requests, release notes from Jira, sync release notes, edit release notes.'
argument-hint: "Path to the release notes file. Optionally add one or both sources: docs/release-notes.md https://example.atlassian.net/projects/CHEF/versions/43153/tab/release-report-all-issues — or — docs/release-notes.md chef/chef-infra-client — or — docs/release-notes.md https://example.atlassian.net/projects/CHEF/versions/43153/tab/release-report-all-issues chef/chef-infra-client — or — docs/release-notes.md (style and structure edit only)"
---

# Review and edit release notes from Jira and pull requests

Runs a five-stage workflow to review a release notes file using Jira release data and
GitHub pull requests as optional sources.
If entries for the release are already drafted, the skill reviews and improves them using
the available source data.
If no entries exist yet, it adds new sections.
If no Jira or GitHub PR sources are provided, the skill edits the file for style and
structure only.

Read-only policy:
- Use GitHub and Jira only to read and retrieve data needed for analysis.
- Never create, update, edit, transition, comment on, assign, delete, or otherwise modify
   anything in GitHub or Jira.
- Apply edits only to the local release notes file in the workspace.

0. **Determine inputs** — identifies which sources are available and maps which stages to run
1. **Parse** — reads the release notes file, extracts every PR reference, and determines
   whether entries for this release are already drafted
2. **Fetch Jira issues** — uses the Atlassian MCP server to retrieve all issues in the
   Jira release or epic
3. **Fetch PRs** — uses the GitHub MCP server to retrieve the title, body, and linked
   issues for each referenced PR
4. **Edit** — if entries are already drafted, reviews and improves them; if not, adds new
   sections from the available source data, then applies the team style guide

---

## What to ask the user

Before starting, confirm these inputs if not already provided:

1. **Release notes file path** — the path to the Markdown file to review, for example:
   `docs/release-notes/v2.4.md`

2. **Jira release URL or epic key** (optional) — one of the following:
   - **Jira release/version URL** — for example:
     `https://progresssoftware.atlassian.net/projects/CHEF/versions/43153/tab/release-report-all-issues`.
     The skill will parse the project key and version ID from the URL.
   - **Jira epic key** — for example: `PLATFORM-456`.

3. **GitHub repository** (optional) — the `owner/repo` the PRs belong to, for example:
   `chef/chef`.
   Skip this if every PR reference is a full URL (for example,
   `https://github.com/chef/chef/pull/123`).

Inputs 2 and 3 are both optional. If neither is provided, the skill edits the file for
style and structure only, using the team style guides.

---

## Stage 0: Determine available inputs

Before running any other stage, identify which inputs are available and map which stages
to run.

Check the following:

| Input | Present? | Effect |
|-------|----------|--------|
| Jira release URL or epic key | Yes | Run Stage 2 |
| Jira release URL or epic key | No | Skip Stage 2 |
| GitHub repository provided, or PR references in file | Yes | Run Stage 3 |
| GitHub repository provided, or PR references in file | No | Skip Stage 3 |

If no sources are available (both Stage 2 and Stage 3 will be skipped), Stage 4 runs in
style-only mode: the file is edited for style and structure using the team style guides.

Before moving to Stage 1, report:

- Which data sources are available (Jira, GitHub PRs, or both)
- Which stages will run and which will be skipped
- Whether Stage 4 will run in edit mode, add mode, or style-only mode

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

Also determine whether entries for this release are already drafted in the file:

- Look for a section heading or block of content that matches the release version, date,
  or product name for this release.
- If entries exist (non-empty sections with release-specific content), record this as
  **edit mode** for Stage 4.
- If no entries exist for this release, or the file contains only placeholder text,
  record this as **add mode** for Stage 4.

Report the number of PR references found and whether the file is in edit mode or add mode
before moving to Stage 2.

---

## Stage 2: Fetch Jira release issues

This stage runs if the user provided a Jira release URL or epic key (see Stage 0).
Skip this stage if neither was provided.

Use the Atlassian MCP server to fetch issues. Follow the path that matches what the user
provided.

Jira access must be read-only:
- Allowed: get/read/search operations that retrieve release, epic, and issue details.
- Not allowed: create or edit issues, add comments, change status/transitions, change
   assignees, modify fields, or perform any other write operation.

### Path A: Jira release/version URL

If the user provided a Jira release/version URL (for example,
`https://progresssoftware.atlassian.net/projects/CHEF/versions/43153/tab/release-report-all-issues`):

1. Parse the URL to extract the **project key** (for example, `CHEF`) and the
   **version ID** (for example, `43153`).
2. Use the Atlassian MCP server to fetch all issues in that version, filtered to
   issues with status `Done` (or equivalent resolved status).
3. For each issue, collect:
   - **Key** — for example, `CHEF-457`
   - **Summary** — the issue title
   - **Issue type** — for example, `Story`, `Bug`, `Task`
   - **Status** — for example, `Done`
   - **Description** — the acceptance criteria or problem statement
4. Proceed to Step 2c.

### Path B: Jira epic key

If the user provided a Jira epic key (for example, `PLATFORM-456`):

#### Step 2b-i: Fetch the epic

Retrieve the epic by key. From the epic record, collect:

- **Summary** — the epic title
- **Description** — the epic's goal and scope
- **Status** — for example, `In Progress`, `Done`
- **Fix version(s)** — the release this epic targets

#### Step 2b-ii: Fetch child issues

Retrieve all issues linked to the epic. For each child issue, collect:

- **Key** — for example, `PLATFORM-457`
- **Summary** — the issue title
- **Issue type** — for example, `Story`, `Bug`, `Task`
- **Status** — for example, `Done`, `In Progress`
- **Description** — the acceptance criteria or problem statement

### Step 2c: Map Jira issues to PRs

Many PR bodies reference a Jira issue key (for example, `CHEF-457` or `PLATFORM-457`) in
their description or title.
Cross-reference the issues collected in Path A or Path B against the PR bodies fetched
in Stage 3.
Build a mapping of Jira issue keys to PR numbers where a match exists.

This mapping lets Stage 4 use Jira acceptance criteria and feature descriptions alongside
PR changes when writing or editing release notes.

---

## Stage 3: Fetch pull request details from GitHub

This stage runs if a GitHub repository was provided or if PR references were found in the
release notes file (see Stage 0). Skip this stage if neither applies.

Use the GitHub MCP server to fetch details for each PR in the list from Stage 1.

GitHub access must be read-only:
- Allowed: get/list/read operations that retrieve PR and issue details.
- Not allowed: create, update, merge, close, reopen, comment, review, label changes,
  branch creation, file writes, or any other repository mutation.

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

## Stage 4: Edit the release notes

Stage 4 operates in one of three modes based on what was determined in Stage 0 and
Stage 1:

- **Edit mode** — entries for this release are already drafted in the file; review and
  improve them using Jira data from Stage 2 and PR data from Stage 3.
- **Add mode** — no entries exist yet for this release; add new sections populated from
  Jira data and/or PR data.
- **Style-only mode** — no Jira or GitHub PR sources were provided; edit the file for
  style and structure only, using the team style guides.

Apply the following guidelines when writing in either mode:

- **Release notes doc type guidelines** from
  [doc-types.instructions.md](../../instructions/doc-types.instructions.md) — use the
  release notes section for structural guidance, section order, entry format, tense rules,
  and language conventions. This is the primary reference for how release notes should be
  structured and written.
- **Team prose style guide** from
  [docs-style.instructions.md](../../instructions/docs-style.instructions.md)
  — apply for voice, tone, word choice, and formatting consistency.

### Edit mode: entries already drafted

Work through each release note entry in the order it appears in the file.

For each entry:

1. **Read the existing note** and retrieve any matching data from Stage 2 (Jira) and
   Stage 3 (GitHub PRs).

2. **Assess accuracy.** The existing note may be:
   - Accurate and complete — keep it, make only style corrections
   - Accurate but vague — expand it using the available source data
   - Inaccurate or missing key information — rewrite it
   - A placeholder (for example, "See PR #123") — replace it with a real note

3. **Draft the revised note** using the following sources in priority order:
   - **Jira issue description or acceptance criteria** and **PR body** — treat these as
     co-equal top-priority sources; use whichever provides the clearest user-facing
     context, or combine both
   - **PR title** — useful when the PR body is sparse
   - **Linked issues in the PR body** — can reveal the original bug report or feature
     request

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
   Ensure the file uses the correct section order and omits any empty sections.
   The defined sections are:
   - Breaking changes (always first, if present)
   - New features
   - New features requiring configuration updates
   - Improvements
   - Bug fixes
   - Known issues
   - Deprecated features
   - Packages

   If sections are missing, misordered, or need to be created based on the source data,
   add or reorder them to match the template.

   Delete any section heading that has no associated content. A section is empty if the
   only content under the heading is one of the following:
   - No content — the heading is immediately followed by the next heading or end of file
   - A placeholder bullet with no text: `- ` (dash and space only)
   - A placeholder value: `- None`, `- N/A`, `None`, `N/A`, or similar

   Don't add a comment or flag before deleting — just remove the heading and any
   placeholder content.

   If the file contains a section that is **not** in the template above, don't delete
   it. Instead, do the following in a single pass over all notes in that section:

   **Classify notes for relocation** — if the section name suggests it may contain
   release-note-worthy content (for example, "Technical changes", "Miscellaneous",
   "Other", "Internal changes"), read all its entries at once and classify each note
   using these signal words:

   | Signal | Destination section |
   |--------|-------------------|
   | Present-tense "adds", "lets you", "supports", "introduces" | New features or Improvements |
   | Past-tense "fixed", "resolved", "corrected" | Bug fixes |
   | "deprecated", "removed", "no longer" | Deprecated features |
   | "breaking", "requires updating", "must migrate" | Breaking changes |

   Apply a confidence threshold: only move a note when its destination section is
   unambiguous. If a note is vague or could fit more than one section, leave it in
   place. Move confirmed notes into the appropriate template section and apply the
   style rules from step 4.

   If the section name clearly doesn't map to release note content (for example,
   "Legal notices", "Acknowledgements"), skip classification and go directly to
   style edits.

   **Edit remaining content** — apply the team style guide to any notes that stay in
   the section.

   **Flag the section for review** — add an HTML comment immediately above the section
   heading regardless of how many notes were moved:

   ```markdown
   <!-- TODO: review — this section is not defined in the release notes doc type; confirm it should be included -->
   ```

6. **Flag notes that need human review** with an inline comment if:
   - The referenced PR was not merged or returned an error in Stage 3
   - The PR body is empty or too sparse to determine what changed
   - The change appears breaking (label `breaking change` or PR body says so explicitly)

   Use this format for the flag:

   ```markdown
   <!-- TODO: verify — PR #NNN could not be fetched or body is insufficient -->
   ```

#### Jira-only or PR-only data in edit mode

If only Jira data is available (Stage 3 was skipped):

- Write notes using Jira issue descriptions and summaries as the sole source.
- Flag each note: `<!-- TODO: verify — no PR found; written from Jira data only -->`.

If only GitHub PR data is available (Stage 2 was skipped):

- Write notes using PR body and title as the sole source.
- The editing guidelines above apply without modification.

### Add mode: no entries yet for this release

When no entries exist for this release, add new sections to the file populated from Jira
issues and/or PR data.

1. **Create the release section** at the appropriate location in the file, using the
   version number, product name, and release date.
   Follow the release notes section template in
   [doc-types.instructions.md](../../instructions/doc-types.instructions.md).

2. **Map each source item to a section** based on issue type or PR label:

   | Jira issue type / PR label | Release notes section |
   |----------------------------|-----------------------|
   | Bug | Bug fixes |
   | Story, Feature, Enhancement | New features or Improvements |
   | Epic | New features (if a major capability) or Improvements |
   | Task, Sub-task | Improvements |
   | `breaking change` label | Breaking changes |
   | `deprecated` label | Deprecated features |

3. **Write each note** using the same source priority as edit mode:
   - Jira issue description or acceptance criteria and PR body — co-equal top priority
   - PR title — use when the PR body is sparse
   - Linked issues — for bug report or feature request context

4. **Apply the same style rules** from step 4 in edit mode above.

5. **Check section structure** and include only sections that have entries.
   Delete any heading with no content or with only placeholder text such as `- None`,
   `- N/A`, `- ` (empty bullet), or similar.

6. **Flag notes that need human review.**
   For Jira items with no matching PR:

   ```markdown
   <!-- TODO: verify — added from Jira ISSUE-NNN; no PR found -->
   ```

   For PR items with a sparse body:

   ```markdown
   <!-- TODO: verify — PR #NNN body is sparse; review for accuracy -->
   ```

#### Jira-only or PR-only data in add mode

If only Jira data is available (Stage 3 was skipped):

- Build each note from the Jira issue summary, description, and acceptance criteria.
- Flag every added note: `<!-- TODO: verify — added from Jira data only; no PR cross-reference found -->`.

If only GitHub PR data is available (Stage 2 was skipped):

- Build each note from the PR body and title.
- Map the note to a section using PR labels as a guide (for example, `bug` → Bug fixes).

### Style-only mode: no source data available

When no Jira or GitHub PR data is available, edit the file for style and structure only.

1. **Read each existing entry** in the file.

2. **Apply the style rules** from step 4 in edit mode above — tense, voice, person,
   sentence length, serial comma, and so on.

3. **Check section structure** against the release notes template in
   [doc-types.instructions.md](../../instructions/doc-types.instructions.md), using the
   same rules as edit mode step 5.

4. **Don't infer or expand** content — only correct what's already written for style,
   grammar, and structure. Don't add context, rewrite entries for accuracy, or flag notes
   as needing content review, since there's no source data to verify against.

### Breaking changes

If a PR is labeled `breaking change` or its body explicitly states the change is breaking:

- Move the note into a **Breaking changes** section if one exists in the file
- If no such section exists, add one immediately above the first regular change section
- Write the note to clearly explain what breaks and what users need to do

---

## Final summary

After editing the file, report:

- **Mode**: whether Stage 4 ran in edit mode, add mode, or style-only mode
- **Jira issues used**: how many Jira issues were retrieved and used as source data (or
  "Stage 2 skipped" if no Jira URL was provided); include whether a release/version or
  epic was used
- **PRs reviewed**: how many PR references were found and fetched (or "Stage 3 skipped"
  if GitHub PRs were not available)
- **Notes updated**: how many entries were changed and a one-line description of each change
- **Notes added**: in add mode, how many new entries were created
- **Notes unchanged**: how many entries needed no edits
- **Sections removed**: list any section headings that were deleted because they had no
  content or contained only placeholder text
- **Flagged for review**: list each flagged note with its PR number or Jira key and the
  reason it was flagged; include any sections flagged as unrecognized
- **Breaking changes**: whether any breaking change notes were identified or moved
