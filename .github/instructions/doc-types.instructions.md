---
description: "Use when asking about doc structure, how to organize a document, or what sections to include. Covers structural templates for tutorials, how-to guides, reference docs, conceptual docs, release notes, and READMEs."
---

# Doc type structures

Source guidance: [The Good Docs Project](https://www.thegooddocsproject.dev/template/)

---

## Tutorial

**Purpose**: Learning-oriented. The reader follows a guided path and ends with a working result and new skills. Assumes no prior practical knowledge of the tool. Tutorials eliminate unexpected scenarios — engineer the reader toward a successful finish.

Tutorials differ from how-to guides: tutorials teach; how-to guides guide experienced users through a task.

```markdown
# <Title: what the reader will build or achieve>

One paragraph explaining what the reader will build and why it matters to a DevOps engineer.

## Overview

### Learning objectives

By the end of this tutorial, you'll be able to:

- <Skill or action the reader can perform>
- <Skill or action the reader can perform>

### Intended audience

Who this tutorial is for and what prior knowledge is assumed.

## Background (optional)

Any context the reader needs before starting — feature explanation, project structure, key concepts.
Keep this brief; link to conceptual docs for deeper explanations.

## Before you begin

- Prerequisite 1 (link to setup steps where applicable)
- Prerequisite 2

## Step 1: <Bare infinitive action — "Configure the namespace">

Introductory sentence explaining what this step accomplishes and why.

1. Step action. Start with an imperative verb.
2. Step action.

   ```shell
   # Comment explaining what this command does
   command --flag <value>
   ```

   Expected result: describe what the reader should see.

## Step 2: <Action>

...

## Summary

Recap the specific skills and knowledge the reader gained. Don't repeat the learning objectives
word-for-word — describe what they actually built or configured.

## Clean up (include if tutorial creates persistent or billable resources)

Steps to remove resources created during the tutorial.

## Next steps

- Link to a related how-to guide
- Link to a related conceptual doc or advanced tutorial
```

**Guidelines**:
- Tutorials should take 15–60 minutes to complete
- Keep steps to a maximum of 7 primary steps; maximum 4 substeps per step
- Each step builds on the previous one — don't jump ahead
- Show expected output after commands so the reader can verify success
- Use real, working examples — not placeholder logic
- Add comments to all code samples explaining what each part does
- Include a "Clean up" section whenever the tutorial creates persistent or billable resources

---

## How-to guide

**Purpose**: Task-oriented. Helps an experienced reader complete one specific task or solve one specific problem. Assumes the reader has practical knowledge and knows what they want to achieve. Alerts readers to unexpected scenarios; it doesn't eliminate them the way a tutorial does.

```markdown
# <Title: bare infinitive — "Deploy a container to Kubernetes">

One or two sentences describing the task and when a reader would perform it.
For example: "Use this guide to create a Kubernetes NetworkPolicy that restricts pod-to-pod traffic."

## Before you begin (include only for non-obvious prerequisites)

- Prerequisite: tool, permission, or environment needed
- Link to relevant setup docs

## <Task name: bare infinitive>

Introductory sentence describing what these steps accomplish.

1. Step one. Start with an imperative verb.
2. Step two.

   ```shell
   # Comment explaining the command
   command --flag <value>
   ```

   Expected output or result.

3. If <condition>, do <alternative step>.

## See also

- Link to a related how-to guide
- Link to a relevant conceptual doc or reference page
```

**Guidelines**:
- One how-to guide covers exactly one task
- Maximum 8–10 steps; if longer, split into multiple guides
- Use conditional imperatives for variations: "If you want X, do Y. To achieve Z, run..."
- Don't explain concepts in the steps — link to conceptual docs instead
- Document only the most common or recommended method; omit or link to alternative methods
- Alert readers to possible unexpected scenarios with `> **Note:**` or `> **Warning:**` admonitions
- Test instructions end-to-end before publishing; re-test after every notable product release

---

## Reference doc

**Purpose**: Provides accurate, complete technical information designed to be scanned, not read top to bottom. Mirrors the structure of the application or system it documents. Avoid high-level instructions or usage guides — link to how-to guides instead.

```markdown
# <Title: noun phrase — "kubectl rollout options">

One sentence describing what this reference covers.

## Syntax

`command [flags] <arguments>`

## Description

What the command, option set, or configuration does. Keep this concise.

## Options

| Flag / Option | Type | Default | Description |
|---------------|------|---------|-------------|
| `--flag` | string | `""` | What it does |
| `--required-flag` | int | required | What it does |

## Examples

```shell
# Description of what this example does
command --flag <value>
```

```shell
# Description of a second variation
command --flag <value> --other-flag
```

## Related

- Link to related reference page
- Link to related how-to guide
```

**Guidelines**:
- Every flag, option, and parameter must be documented; include type and default
- Use `required` in the Default column when there is no default value
- Examples must be present — at least two, showing different configurations
- Use active voice in descriptions: "Returns a JSON object" not "A JSON object is returned"
- Use tables and bulleted lists to maximize scannability
- Maintain consistent structure, terminology, and tone across all reference pages
- Don't include step-by-step procedures — link out to how-to guides

---

## Conceptual doc

**Purpose**: Helps readers understand a concept, architecture, or system. Provides foundational knowledge so readers can understand how-to guides and reference docs in context. Builds mental models; does not teach by doing.

Conceptual docs appear early in documentation journeys, or as mid-level layers when a reader encounters an unfamiliar concept in a how-to guide.

```markdown
# <Title: noun phrase — "Deployment strategies in Kubernetes">

(Optional) An introductory paragraph framing the concept's relevance and what the page covers.
Apply the inverted pyramid: start with the high-level idea, then go deeper.

## What is <concept>

A clear definition scoped to what this document covers. State what is in scope and, where useful,
what is out of scope. Explain how the concept fits into the broader system or workflow.
Use analogies where they help — prefer universally understood comparisons.

## (Optional) <Diagram or visual>

If a diagram clarifies the architecture or data flow, describe or embed it here, near the top.

## (Optional) Background

Historical context, design decisions, or industry context that affects how the concept works.
Include only if it meaningfully aids understanding.

## Use cases

When and why a DevOps engineer would use or encounter this concept.
Frame use cases around the reader's problems: what challenges does this concept solve?

## (Optional) Comparison

If the concept has multiple types, versions, or similar alternatives, include a comparison table.

| | When to use |
|---|-------------|
| <Option 1> | <Reason> |
| <Option 2> | <Reason> |

## Related resources

- Link to related conceptual doc
- Link to how-to guide that implements this concept
- Link to reference doc for this concept's options or configuration
```

**Guidelines**:
- One conceptual doc covers exactly one concept; if explaining a second concept becomes necessary, link to a separate doc
- Don't include step-by-step procedures — add a `<!-- TODO: link to how-to guide for [task] -->` comment where a procedure link should go
- Use the inverted pyramid: high-level overview first, details later
- Include a diagram whenever it clarifies structure, data flow, or relationships
- Explain trade-offs and limitations honestly

---

## Release notes

**Purpose**: Communicate new features, improvements, bug fixes, and known issues to stakeholders. Release notes are customer-facing — use plain language, not developer-facing changelog language. Written for both technical and non-technical readers.

```markdown
# Release notes — v<version> (<YYYY-MM-DD>)

(Optional) One to two sentences highlighting the most important items in this release.

## Breaking changes (include if present — always lead with this section)

> **Warning:** The following changes require action before upgrading.

- **<Change name>**: What changed, what the reader must do, and a link to the migration guide.

## New features

- **<Feature name>**: What the feature does and how it benefits the reader.
  See [<feature docs>](<link>) for more information.

## New features requiring configuration updates

- **<Feature name>**: What the feature does. To use this feature, you must <describe the required config>.
  See [<feature docs>](<link>) for configuration steps.

## Improvements

- **<Area or feature>**: What was added, updated, or removed and the benefit to the reader.

## Bug fixes

- **[<issue-id>](<link>) <Short description>**: <What the software now does correctly>.
  See [<docs link>](<link>) for more information.

## Known issues

- **[<issue-id>](<link>) <Short description>**: <What happens and in what scenario>.
  Workaround: <Steps to work around the issue, if available>.

## Deprecated features (optional)

- **<Feature name>**: <Feature> will be removed in <version or date>.
  <Replacement feature> replaces it. The system will <describe data migration if applicable>.
  See [<deprecated feature docs>](<link>).
```

**Guidelines**:
- Write in a positive, friendly tone; use plain language
- Use second person: "You can now...", "Use the new... to..."
- Use present tense for new features and improvements: "Adds support for...", "Lets you..."
- Use past tense for bug fixes: "Fixed an issue where...", "Resolved a problem that caused..."
- Don't start bug fix entries with "Fixed the bug..." — describe what the software now does correctly
- List the most important items in each section first
- Include issue or PR numbers and link them where your organization permits
- Omit any section that has no entries
- Use semantic versioning for release numbers (for example, `1.3.2`); include the date in `YYYY-MM-DD` format

---

## README

**Purpose**: The first document a reader finds in a repository. Answers: what is this, who is it for, why should I care, and how do I start? Focus on why a reader would engage with the project, not just what it does.

```markdown
# <Project name>

One sentence describing what the project does and who it's for.

## Project description

Expand on what the project does and why a reader should use it.
Use these patterns:

- "With <project>, you can <verb> <noun>..."
- "<Project> helps you <verb> <noun>..."
- "Unlike <alternative>, <project> <verb> <noun>..."

Include a screenshot or short video if it helps readers understand the project quickly.

## Who is this for

Who can use this project, what problems it helps them solve, and what tasks it helps them accomplish.

## Dependencies

List what the reader needs before they can use the project, and why each dependency is needed.
Link to installation instructions for each.

- <Dependency>: <Why it's needed> — [Install](<link>)

## Installation

```shell
# Install command
<command>
```

## Configuration

| Variable / Option | Default | Description |
|-------------------|---------|-------------|
| `VAR_NAME` | `""` | What it controls |

## Quick start

The minimum steps to get something working. Keep to five steps or fewer.

1. Step one.
2. Step two.

## Usage

```shell
# Description of what this does
command --flag <value>
```

## Troubleshooting

| Problem | Solution |
|---------|----------|
| <Error or symptom> | <How to fix it> |

## Contributing

Brief inline guide or link to `CONTRIBUTING.md`.

## How to get help

Where to ask questions, report bugs, or get support.
For example: link to issues, a Slack channel, a mailing list, or Stack Overflow.

## Additional documentation

- [<Doc title>](<link>) — brief description
- [<Doc title>](<link>) — brief description

## License

License name and a link or brief statement.
```

**Guidelines**:
- Lead with why, not just what — explain why a reader should care before describing technical details
- Keep the README scannable: short paragraphs, code blocks for all commands, clear headings
- The quick start must be minimal — the simplest path to a working result
- Include a troubleshooting table for the most common errors new users encounter
- Don't duplicate information that lives in linked docs — link instead
- Revisit the README regularly as the project evolves
